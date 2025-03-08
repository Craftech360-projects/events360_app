import 'dart:math' as math;

import 'package:events360/core/constants/constants.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Future<void> _launchUrl(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link')),
        );
      }
    } on Exception catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo and Name
              Center(
                child: Column(
                  children: [
                    _buildAnimatedLogo(),
                    Constants.h16,
                    Text(
                      'Craftech360',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'Augmenting Incredible Experiences',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Constants.h32,

              // Company Description
              _buildSectionTitle(context, 'Who We Are'),

              Text(
                'Ours is a startup company. We Augment Incredible Experiences. A memorable fun experience through blending of physical and digital activations.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              Constants.h24,

              // Our Fields
              _buildSectionTitle(context, 'Our Fields'),
              Constants.h16,
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildFieldChip(context, 'SCI-FI', Icons.science),
                  _buildFieldChip(context, 'IMMERSIVE', Icons.view_in_ar),
                  _buildFieldChip(context, 'INTERACTIVE', Icons.touch_app),
                  _buildFieldChip(context, 'GAMING', Icons.sports_esports),
                  _buildFieldChip(context, 'DESIGN', Icons.design_services),
                ],
              ),

              Constants.h24,

              // What We Do
              _buildSectionTitle(context, 'What We Do'),

              Text(
                'We build interactive and immersive worlds, using an approach at the crossroads of design, gaming and borderline sci-fi.\n\nWe mainly provide Digital Engagement Activities. Craftech360 collectively has over 8 years of experience in the events space. We\'ve powered music festivals, movie launches and even built entire life-size holograms with one intent in mind - make you go wow.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              Constants.h32,

              // Social Media
              _buildSectionTitle(context, 'Connect With Us'),
              Constants.h16,
              _buildSocialMediaButton(
                context,
                'Instagram',
                Icons.camera_alt,
                AppColors.purpleBright,
                'https://www.instagram.com/craftech360/',
              ),

              _buildSocialMediaButton(
                context,
                'X (Twitter)',
                Icons.alternate_email,
                Colors.blue,
                'https://twitter.com/craftech360/',
              ),

              _buildSocialMediaButton(
                context,
                'YouTube',
                Icons.play_arrow,
                Colors.red,
                'https://www.youtube.com/channel/UC6SMojTms6EKqXqa-Am8HMA',
              ),

              _buildSocialMediaButton(
                context,
                'Facebook',
                Icons.facebook,
                Colors.blue.shade800,
                'https://www.facebook.com/craftech360/',
              ),

              _buildSocialMediaButton(
                context,
                'LinkedIn',
                Icons.work,
                Colors.blue.shade900,
                'https://www.linkedin.com/company/craftech360/',
              ),

              Constants.h32,

              // Contact
              _buildSectionTitle(context, 'Contact Us'),

              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.email, size: 24),
                      Constants.w16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email Us',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Constants.h4,
                            Text(
                              'pradeep@craftech360.com',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.blue,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => _launchUrl(
                          'mailto:pradeep@craftech360.com',
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Constants.h32,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 2 * math.pi),
      duration: const Duration(seconds: 20),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.yellow.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: child,
          ),
        );
      },
      child: const Icon(
        Icons.auto_awesome,
        size: 60,
        color: AppColors.yellow,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          color: AppColors.yellow,
        ),
        Constants.w8,
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildFieldChip(BuildContext context, String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildSocialMediaButton(
    BuildContext context,
    String platform,
    IconData icon,
    Color color,
    String url,
  ) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => _launchUrl(url, context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              Constants.w16,
              Text(
                platform,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
