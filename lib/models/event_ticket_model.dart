class EventTicketModel {
  String? id;
  final String eventName;
  final String eventDescription;
  final DateTime eventDate;
  final double ticketValue;
  final int availableTickets;
  final String eventImage;

  EventTicketModel({
    this.id,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.ticketValue,
    required this.availableTickets,
    required this.eventImage,
  });

  factory EventTicketModel.fromJson(Map<String, dynamic> json) {
    return EventTicketModel(
      id: json['id'],
      eventName: json['eventName'] ?? '',
      eventDescription: json['eventDescription'] ?? '',
      eventDate: json['eventDate'] != null
          ? DateTime.parse(json['eventDate'])
          : DateTime.now(),
      ticketValue:
          json['ticketValue'] != null ? json['ticketValue'].toDouble() : 0.0,
      availableTickets: json['availableTickets'] ?? 0,
      eventImage: json['eventImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventDate': eventDate.toIso8601String(),
      'ticketValue': ticketValue,
      'availableTickets': availableTickets,
      'eventImage': eventImage,
    };
  }
}
