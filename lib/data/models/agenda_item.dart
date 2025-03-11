import 'package:events360/data/models/speaker.dart';

class AgendaItem {
  final int id;
  final int eventId;
  final String title;
  final String description;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final Speaker? speaker;

  AgendaItem({
    required this.id,
    required this.eventId,
    required this.title,
    required this.description,
    required this.location,
    required this.startTime,
    required this.endTime,
    this.speaker,
  });

  factory AgendaItem.fromJson(Map<String, dynamic> json) {
    return AgendaItem(
      id: json['id'],
      eventId: json['event_id'],
      title: json['title'],
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      speaker: json['speaker'] != null ? Speaker.fromJson(json['speaker']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'title': title,
      'description': description,
      'location': location,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'speaker_id': speaker?.id,
    };
  }
}
