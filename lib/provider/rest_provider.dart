import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:trab/models/event_ticket_model.dart';

class EventTicketRestProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  late WebSocketChannel _channel;

  final String _baseUrl =
      'https://c64554c3-1f3d-4518-b41f-d30e75cbd45d-00-1vzg7wl6bqjyz.picard.replit.dev/api/tickets/';

  List<EventTicketModel> _tickets = [];
  List<EventTicketModel> get tickets => _tickets;

  EventTicketRestProvider() {
    _initializeWebSocket();
    getAllEventTickets();
  }

  Stream<Map<String, dynamic>> get stream =>
      _channel.stream.map((event) => jsonDecode(event) as Map<String, dynamic>);

  void _initializeWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(
        'wss://c64554c3-1f3d-4518-b41f-d30e75cbd45d-00-1vzg7wl6bqjyz.picard.replit.dev/'));
    _channel.stream.listen(
      (event) {
        final data = jsonDecode(event) as Map<String, dynamic>;
        if (data.containsKey('ticketDeleted')) {
          _tickets.removeWhere((ticket) => ticket.id == data['id']);
        } else if (data.containsKey('ticketAdded')) {
          _tickets.add(EventTicketModel.fromJson(data));
        } else if (data.containsKey('ticketUpdated')) {
          final index =
              _tickets.indexWhere((ticket) => ticket.id == data['id']);
          if (index != -1) {
            _tickets[index] = EventTicketModel.fromJson(data);
          }
        }
        notifyListeners();
      },
      onDone: _handleWebSocketDone,
      onError: (error) => print('WebSocket Error: $error'),
    );
  }

  void _handleWebSocketDone() {
    print('WebSocket connection closed. Reconnecting...');
    Future.delayed(const Duration(seconds: 1),
        _initializeWebSocket); // Tentativa de reconexão
  }

  Future<String?> createEventTicket(EventTicketModel eventTicket) async {
    try {
      Response response = await _dio.post(_baseUrl, data: eventTicket.toJson());
      if (response.statusCode == 200) {
        return response.data['_id'];
      }
    } catch (e) {
      print('Failed to create event ticket: $e');
    }
    return null;
  }

  Future<void> updateEventTicket(
      String id, EventTicketModel eventTicket) async {
    try {
      await _dio.put('$_baseUrl$id', data: eventTicket.toJson());
    } catch (e) {
      print('Failed to update event ticket: $e');
    }
  }

  Future<void> deleteEventTicket(String id) async {
    try {
      await _dio.delete('$_baseUrl$id');
    } catch (e) {
      print('Failed to delete event ticket: $e');
    }
  }

  Future<EventTicketModel> getEventTicket(String id) async {
    try {
      Response response = await _dio.get('$_baseUrl$id');
      return EventTicketModel.fromJson(response.data);
    } catch (e) {
      print('Failed to get event ticket: $e');
      rethrow;
    }
  }

  Future<List<EventTicketModel>> getAllEventTickets() async {
    try {
      Response response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        List<EventTicketModel> eventTickets = (response.data as List)
            .map((item) => EventTicketModel.fromJson(item))
            .toList();
        _tickets = eventTickets;
        notifyListeners();
        return eventTickets;
      }
    } catch (e) {
      print('Failed to load tickets: $e');
      throw Exception('Failed to load tickets');
    }
    return [];
  }
}
