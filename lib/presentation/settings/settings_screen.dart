import 'package:events360/presentation/settings/about_us.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: ListView(
        children: [
          ListTile(
            title:
                Text('About Us', style: Theme.of(context).textTheme.titleLarge),
            leading: const Icon(Icons.info),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AboutUs())),
          ),
          ListTile(
            title: Text('Contact Support',
                style: Theme.of(context).textTheme.titleLarge),
            leading: const Icon(Icons.support),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Contact Support'),
                  content: const Text(
                      'If you have any queries or need assistance, please email us at\napps.cft360@gmail.com'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
              title: Text('View Privacy Policy',
                  style: Theme.of(context).textTheme.titleLarge),
              leading: const Icon(Icons.privacy_tip),
              onTap: () async {
                final url = Uri.parse(
                    'https://www.freeprivacypolicy.com/live/667e052b-0555-41bb-832f-f4c416fd7075');
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                try {
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                          content: Text('Could not open privacy policy')),
                    );
                  }
                } on Exception catch (e) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }),
        ],
      ),
    );
  }
}
