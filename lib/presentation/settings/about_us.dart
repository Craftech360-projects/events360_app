import 'package:events360/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('About Us', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Text(
              textAlign: TextAlign.center,
              'We are a leading company specializing in providing innovative software and hardware products designed to enhance and streamline event experiences, ensuring seamless and memorable occasions for all attendees.',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
