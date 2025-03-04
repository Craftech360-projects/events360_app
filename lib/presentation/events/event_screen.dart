import 'package:events360/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class Event {
  final String name;
  final String date;
  final String location;
  final double rating;

  Event(
      {required this.name,
      required this.date,
      required this.location,
      required this.rating});
}

final List<Event> events = [
  Event(
      name: 'Music Concert',
      date: '2023-11-01',
      location: 'Mumbai',
      rating: 8.5),
  Event(
      name: 'Art Exhibition',
      date: '2023-11-05',
      location: 'Delhi',
      rating: 9.0),
  Event(
      name: 'Food Festival',
      date: '2023-11-10',
      location: 'Chennai',
      rating: 8.0),
  Event(
      name: 'Tech Conference',
      date: '2023-11-15',
      location: 'Bangalore',
      rating: 9.5),
  Event(
      name: 'Book Fair', date: '2023-11-20', location: 'Kolkata', rating: 7.5),
  Event(
      name: 'Film Festival',
      date: '2023-11-25',
      location: 'Hyderabad',
      rating: 8.8),
  Event(
      name: 'Fashion Show', date: '2023-11-30', location: 'Pune', rating: 9.2),
  Event(
      name: 'Marathon', date: '2023-12-05', location: 'Ahmedabad', rating: 8.3),
  Event(
      name: 'Dance Competition',
      date: '2023-12-10',
      location: 'Jaipur',
      rating: 8.7),
  Event(
      name: 'Startup Meetup', date: '2023-12-15', location: 'Goa', rating: 9.1),
];

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(event.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${event.date} - ${event.location}'),
              trailing: Text(event.rating.toString(),
                  style: const TextStyle(color: Colors.blue)),
            ),
          );
        },
      ),
    );
  }
}
