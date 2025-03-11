import 'package:events360/core/assets/app_images.dart';
import 'package:events360/core/constants/constants.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/core/widgets/loader.dart';
import 'package:events360/data/models/agenda_item.dart';
import 'package:events360/data/models/sponsor.dart';
import 'package:events360/data/models/user.dart' as app_user;
import 'package:events360/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);

    if (eventProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: TypingIndicator(),
        ),
      );
    }

    if (eventProvider.hasError || eventProvider.event == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No event data available'),
              ElevatedButton(
                onPressed: () => eventProvider.refreshEventData(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final event = eventProvider.event!;
    final agendaItems = eventProvider.agendaItems;
    final attendees = eventProvider.attendees;
    final sponsors = eventProvider.sponsors;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: AppColors.greyDark,
          color: AppColors.white,
          onRefresh: () => eventProvider.refreshEventData(),
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
                    color: isDarkMode ? AppColors.greyDark : AppColors.white,
                    borderRadius: Constants.br24,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? AppColors.darkBg
                            : AppColors.grey.withValues(alpha: 0.2),
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
                        event.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.yellow,
                            ),
                      ),
                      Constants.h8,
                      Text(
                        event.description,
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
                      _buildSectionHeader(context, 'Event Agenda', isDarkMode),
                      Constants.h16,
                      _buildEventAgendaList(context, isDarkMode, agendaItems),

                      Constants.h32,

                      // Attendees Section
                      _buildSectionHeader(context, 'Attendees', isDarkMode),
                      Constants.h16,
                      _buildAttendeesList(context, isDarkMode, attendees),

                      Constants.h32,

                      // Sponsors Section
                      _buildSectionHeader(context, 'Sponsors', isDarkMode),
                      Constants.h16,
                      _buildSponsorsGrid(context, isDarkMode, sponsors),

                      Constants.h24,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, bool isDarkMode) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
    ]);
  }

  Widget _buildEventAgendaList(
      BuildContext context, bool isDarkMode, List<AgendaItem> agendaItems) {
    if (agendaItems.isEmpty) {
      return const Center(child: Text('No agenda items available'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: agendaItems.length,
      itemBuilder: (context, index) {
        final item = agendaItems[index];
        // Format time for display
        final startTime = TimeOfDay.fromDateTime(item.startTime);
        final endTime = TimeOfDay.fromDateTime(item.endTime);
        final formattedStartTime = startTime.format(context);
        final formattedEndTime = endTime.format(context);
        final timeString = '$formattedStartTime - $formattedEndTime';

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 06),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.greyDark : AppColors.white,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold, height: 1.2),
                  ),
                  Constants.h4,
                  Row(
                    children: [
                      Constants.h4,
                      const Icon(
                        Icons.access_time_rounded,
                        size: 15,
                        color: AppColors.blue,
                      ),
                      Constants.w4,
                      Text(
                        timeString,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (item.speaker != null) ...[
                    Constants.h4,
                    Row(
                      children: [
                        const Icon(
                          Icons.keyboard_voice_rounded,
                          size: 14,
                        ),
                        Constants.w4,
                        Text(
                          item.speaker!.name,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                  Constants.h8,
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 14,
                      ),
                      Constants.w4,
                      Text(
                        item.location,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              Constants.h8,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Icon(
                      Icons.format_list_bulleted_rounded,
                      size: 14,
                    ),
                  ),
                  Constants.w4,
                  Expanded(
                    child: Text(
                      item.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(height: 1.2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttendeesList(
      BuildContext context, bool isDarkMode, List<app_user.User> attendees) {
    if (attendees.isEmpty) {
      return const Center(child: Text('No attendees available'));
    }

    // final List<Map<String, dynamic>> attendees = [
    //   {
    //     'name': 'Emma Watson',
    //     'headline': 'Tech Enthusiast',
    //     'image': 'https://randomuser.me/api/portraits/women/44.jpg',
    //   },
    //   {
    //     'name': 'James Wilson',
    //     'headline': 'Software Dev',
    //     'image': 'https://randomuser.me/api/portraits/men/32.jpg',
    //   },
    //   {
    //     'name': 'Olivia Parker',
    //     'headline': 'UX Designer',
    //     'image': 'https://randomuser.me/api/portraits/women/65.jpg',
    //   },
    //   {
    //     'name': 'Daniel Brown',
    //     'headline': 'Data Scientist',
    //     'image': 'https://randomuser.me/api/portraits/men/83.jpg',
    //   },
    //   {
    //     'name': 'Sophia Miller',
    //     'headline': 'AI Researcher',
    //     'image': 'https://randomuser.me/api/portraits/women/90.jpg',
    //   },
    // ];

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
            backgroundImage: NetworkImage(attendee.imageUrl ?? ""),
          ),
          title: Text(
            attendee.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(attendee.headline ?? ""),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to attendee details
          },
        );
      },
    );
  }

  Widget _buildSponsorsGrid(
      BuildContext context, bool isDarkMode, List<Sponsor> sponsors) {
    if (sponsors.isEmpty) {
      return const Center(child: Text('No sponsors available'));
    }

    // final List<Map<String, dynamic>> sponsors = [
    //   {
    //     'name': 'TechCorp',
    //     'tier': 'Platinum',
    //     'logo': AppImages.userPlaceholder,
    //     'booth': 'A1',
    //   },
    //   {
    //     'name': 'InnovateSoft',
    //     'tier': 'Gold',
    //     'logo': AppImages.userPlaceholder,
    //     'booth': 'B2',
    //   },
    //   {
    //     'name': 'FutureTech',
    //     'tier': 'Gold',
    //     'logo': AppImages.userPlaceholder,
    //     'booth': 'B3',
    //   },
    //   {
    //     'name': 'DataSystems',
    //     'tier': 'Silver',
    //     'logo': AppImages.userPlaceholder,
    //     'booth': 'C4',
    //   },
    // ];

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
            color: isDarkMode ? AppColors.greyDark : AppColors.white,
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
                  child: sponsor.logoUrl.isNotEmpty
                      ? Image.network(
                          sponsor.logoUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImages.userPlaceholder,
                              fit: BoxFit.contain,
                            );
                          },
                        )
                      : Image.asset(
                          AppImages.userPlaceholder,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              Text(
                sponsor.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                '${sponsor.tier} • Booth ${sponsor.booth}',
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
