import 'package:events360/core/assets/app_images.dart';
import 'package:events360/core/constants/constants.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/core/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class SpeakerScreen extends StatelessWidget {
  const SpeakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> speakers = [
      {
        'name': 'John Smith',
        'title': 'CEO, TechCorp',
        'image': AppImages.userPlaceholder, // Changed from network URL
        'topic': 'Opening Keynote',
        'time': '09:00 AM - 10:00 AM',
        'stage': 'Main Stage',
        'bio':
            'John Smith is the CEO of TechCorp with over 20 years of experience in the technology industry.',
      },
      {
        'name': 'Sarah Johnson',
        'title': 'AI Research Lead, InnovateSoft',
        'image': AppImages.userPlaceholder, // Changed from network URL
        'topic': 'Future of AI in Business',
        'time': '10:30 AM - 11:30 AM',
        'stage': 'Hall A',
        'bio':
            'Sarah Johnson leads AI research at InnovateSoft, focusing on practical applications of machine learning in business contexts.',
      },
      {
        'name': 'Michael Chen',
        'title': 'Blockchain Expert',
        'image': AppImages.userPlaceholder,
        'topic': 'Blockchain Revolution',
        'time': '01:30 PM - 02:30 PM',
        'stage': 'Hall B',
        'bio':
            'Michael Chen is a renowned blockchain expert who has consulted for major financial institutions worldwide.',
      },
      {
        'name': 'Emily Rodriguez',
        'title': 'UX Director, DesignHub',
        'image': AppImages.userPlaceholder,
        'topic': 'Human-Centered Design',
        'time': '03:00 PM - 04:00 PM',
        'stage': 'Hall A',
        'bio':
            'Emily Rodriguez has transformed user experiences for dozens of Fortune 500 companies through her innovative design approaches.',
      },
      {
        'name': 'David Kim',
        'title': 'CTO, FutureTech',
        'image': AppImages.userPlaceholder,
        'topic': 'Quantum Computing',
        'time': '04:30 PM - 05:30 PM',
        'stage': 'Hall B',
        'bio':
            'David Kim is at the forefront of quantum computing research and its practical applications in today\'s technology landscape.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Speakers', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: speakers.length,
        itemBuilder: (context, index) {
          final speaker = speakers[index];
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 06),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: Constants.br12,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                _showSpeakerDetails(context, speaker);
              },
              child: Row(
                children: [
                  ProfileAvatar(
                    placeholderImage: speaker['image'],
                    radius: 30,
                  ),
                  Constants.w16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          speaker['name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Constants.h4,
                        Text(
                          speaker['title'],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Topic: ${speaker['topic']}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.blue,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSpeakerDetails(BuildContext context, Map<String, dynamic> speaker) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: Constants.br12,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.commonPink,
                        radius: 30,
                        backgroundImage: AssetImage(speaker['image']),
                      ),
                      Constants.h16,
                      Text(
                        speaker['name'],
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      Constants.h4,
                      Text(
                        speaker['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Constants.h24,
                const Divider(),
                Constants.h16,
                _buildInfoRow(context, 'Topic', speaker['topic']),
                Constants.h8,
                _buildInfoRow(context, 'Time', speaker['time']),
                Constants.h8,
                _buildInfoRow(context, 'Stage', speaker['stage']),
                Constants.h24,
                Text(
                  'Biography',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Constants.h8,
                Text(
                  speaker['bio'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(height: 1.2),
                ),
                Constants.h32,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to calendar or set reminder
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reminder set for this session'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: Constants.br8,
                      ),
                    ),
                    child: const Text('Set Reminder'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
