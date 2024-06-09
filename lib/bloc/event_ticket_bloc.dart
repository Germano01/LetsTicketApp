import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trab/models/event_ticket_model.dart';
import 'package:trab/provider/rest_provider.dart';

class EventTicketBloc extends Bloc<EventTicketEvent, EventTicketState> {
  final EventTicketRestProvider _restProvider = EventTicketRestProvider();

  EventTicketBloc(EventTicketRestProvider of) : super(EventTicketInitial()) {
    on<AddEventTicket>(_onAddEventTicket);
    on<GetAllEventTickets>(_onGetAllEventTickets);
    on<DeleteEventTicket>(_onDeleteEventTicket);
    on<UpdateEventTicket>(_onUpdateEventTicket);
  }

  Future<void> addEventTicket(EventTicketEvent event) async {
    final completer = Completer<void>();

    add(event);

    late StreamSubscription<EventTicketState> subscription;
    subscription = stream.listen((state) {
      if (state is EventTicketOperationSuccess) {
        completer.complete();
        subscription.cancel();
      }
    });

    return completer.future;
  }

  Future<void> _onAddEventTicket(
      AddEventTicket event, Emitter<EventTicketState> emit) async {
    try {
      final String? eventId =
          await _restProvider.createEventTicket(event.ticket);
      if (eventId != null) {
        emit(EventTicketOperationSuccess());
      } else {
        emit(EventTicketOperationFailure(
            error: 'Falha ao tentar criar ingresso de evento!'));
      }
    } catch (e) {
      emit(EventTicketOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onGetAllEventTickets(
      GetAllEventTickets event, Emitter<EventTicketState> emit) async {
    emit(EventTicketLoading());
    try {
      final List<EventTicketModel> tickets =
          await _restProvider.getAllEventTickets();
      emit(EventTicketLoadSuccess(ticketList: tickets));
    } catch (e) {
      emit(EventTicketLoadFailure(error: e.toString()));
    }
  }

  Future<void> _onDeleteEventTicket(
      DeleteEventTicket event, Emitter<EventTicketState> emit) async {
    try {
      await _restProvider.deleteEventTicket(event.ticketId);
      emit(EventTicketOperationSuccess());
    } catch (e) {
      emit(EventTicketOperationFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdateEventTicket(
      UpdateEventTicket event, Emitter<EventTicketState> emit) async {
    try {
      await _restProvider.updateEventTicket(event.ticket.id!, event.ticket);
      emit(EventTicketOperationSuccess());
    } catch (e) {
      emit(EventTicketOperationFailure(error: e.toString()));
    }
  }
}

abstract class EventTicketEvent {}

class GetAllEventTickets extends EventTicketEvent {}

class AddEventTicket extends EventTicketEvent {
  final EventTicketModel ticket;
  AddEventTicket({required this.ticket});
}

class UpdateEventTicket extends EventTicketEvent {
  final EventTicketModel ticket;
  UpdateEventTicket({required this.ticket});
}

class DeleteEventTicket extends EventTicketEvent {
  final String ticketId;
  DeleteEventTicket({required this.ticketId});
}

abstract class EventTicketState {}

class EventTicketInitial extends EventTicketState {}

class EventTicketLoading extends EventTicketState {}

class EventTicketLoadSuccess extends EventTicketState {
  final List<EventTicketModel> ticketList;
  EventTicketLoadSuccess({required this.ticketList});
}

class EventTicketLoadFailure extends EventTicketState {
  final String error;
  EventTicketLoadFailure({required this.error});
}

class EventTicketOperationSuccess extends EventTicketState {}

class EventTicketOperationFailure extends EventTicketState {
  final String error;
  EventTicketOperationFailure({required this.error});
}
