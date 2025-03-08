import 'package:events360/data/models/event.dart';

class Ticket {
  final int id;
  final String userId;
  final int eventId;
  final String ticketType;
  final Event? event;

  Ticket({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.ticketType,
    this.event,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      ticketType: json['ticket_type'],
      event: json['events'] != null ? Event.fromJson(json['events']) : null,
    );
  }
}