import 'package:events360/core/assets/app_images.dart';
import 'package:events360/core/constants/constants.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: Constants.br24,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Tech Summit 2024',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                              ),
                    ),
                    Constants.h8,
                    Text(
                      'Join us for an exciting journey through the latest innovations and technologies.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(height: 1.2),
                    ),
                  ],
                ),
              ),

              Constants.h24,

              // Event Agenda Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'Event Agenda'),
                    Constants.h16,
                    _buildEventAgendaList(context),

                    Constants.h32,

                    // Attendees Section
                    _buildSectionHeader(context, 'Attendees'),
                    Constants.h16,
                    _buildAttendeesList(context),

                    Constants.h32,

                    // Sponsors Section
                    _buildSectionHeader(context, 'Sponsors'),
                    Constants.h16,
                    _buildSponsorsGrid(context),

                    Constants.h24,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: Constants.br4,
              ),
            ),
            Constants.w8,
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        if (title == 'Attendees')
          TextButton(
            onPressed: () {
              // Navigate to all attendees screen
            },
            child: const Text('View All'),
          ),
      ],
    );
  }

  Widget _buildEventAgendaList(BuildContext context) {
    final List<Map<String, dynamic>> agendaItems = [
      {
        'time': '09:00 AM - 10:00 AM',
        'title': 'Opening Keynote',
        'speaker': 'John Smith',
        'location': 'Main Stage',
        'description': 'Welcome address and introduction to the event themes',
      },
      {
        'time': '10:30 AM - 11:30 AM',
        'title': 'Future of AI in Business',
        'speaker': 'Sarah Johnson',
        'location': 'Hall A',
        'description': 'Exploring how AI is transforming business operations',
      },
      {
        'time': '12:00 PM - 01:00 PM',
        'title': 'Networking Lunch',
        'speaker': '',
        'location': 'Dining Area',
        'description': 'Connect with fellow attendees over lunch',
      },
      {
        'time': '01:30 PM - 02:30 PM',
        'title': 'Blockchain Revolution',
        'speaker': 'Michael Chen',
        'location': 'Hall B',
        'description': 'Understanding the impact of blockchain technology',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: agendaItems.length,
      itemBuilder: (context, index) {
        final item = agendaItems[index];
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, height: 1.2),
                        ),
                        if (item['speaker'].isNotEmpty) ...[
                          Constants.h8,
                          Text(
                            'Speaker: ${item['speaker']}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                        Constants.h8,
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            Text(
                              item['location'],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Constants.w4,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue.withValues(alpha: 0.2),
                      borderRadius: Constants.br8,
                    ),
                    child: Text(
                      item['time'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Constants.h8,
              Text(
                item['description'],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.2),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttendeesList(BuildContext context) {
    final List<Map<String, dynamic>> attendees = [
      {
        'name': 'Emma Watson',
        'headline': 'Tech Enthusiast',
        'image': 'https://randomuser.me/api/portraits/women/44.jpg',
      },
      {
        'name': 'James Wilson',
        'headline': 'Software Dev',
        'image': 'https://randomuser.me/api/portraits/men/32.jpg',
      },
      {
        'name': 'Olivia Parker',
        'headline': 'UX Designer',
        'image': 'https://randomuser.me/api/portraits/women/65.jpg',
      },
      {
        'name': 'Daniel Brown',
        'headline': 'Data Scientist',
        'image': 'https://randomuser.me/api/portraits/men/83.jpg',
      },
      {
        'name': 'Sophia Miller',
        'headline': 'AI Researcher',
        'image': 'https://randomuser.me/api/portraits/women/90.jpg',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: attendees.length,
      itemBuilder: (context, index) {
        final attendee = attendees[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(attendee['image']),
          ),
          title: Text(
            attendee['name'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(attendee['headline']),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to attendee details
          },
        );
      },
    );
  }

  Widget _buildSponsorsGrid(BuildContext context) {
    final List<Map<String, dynamic>> sponsors = [
      {
        'name': 'TechCorp',
        'tier': 'Platinum',
        'logo': AppImages.userPlaceholder,
        'booth': 'A1',
      },
      {
        'name': 'InnovateSoft',
        'tier': 'Gold',
        'logo': AppImages.userPlaceholder,
        'booth': 'B2',
      },
      {
        'name': 'FutureTech',
        'tier': 'Gold',
        'logo': AppImages.userPlaceholder,
        'booth': 'B3',
      },
      {
        'name': 'DataSystems',
        'tier': 'Silver',
        'logo': AppImages.userPlaceholder,
        'booth': 'C4',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: sponsors.length,
      itemBuilder: (context, index) {
        final sponsor = sponsors[index];
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: Constants.br8,
                  child: Image.asset(
                    sponsor['logo'],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                sponsor['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                '${sponsor['tier']} • Booth ${sponsor['booth']}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
