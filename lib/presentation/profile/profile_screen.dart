import 'package:events360/core/assets/app_images.dart';
import 'package:events360/core/constants/constants.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/core/widgets/profile_avatar.dart';
import 'package:events360/infrastructure/supabase_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SupabaseService _supabaseService = SupabaseService();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _supabaseService.getCurrentUser();
      if (mounted) {
        setState(() {
          userData = {
            'name': user['name'] ?? 'No Name',
            'headline': user['headline'] ?? 'No Headline',
            'image': user['image_url'] ?? AppImages.userPlaceholder,
            'tickets': [], // You can implement ticket fetching later
          };
          isLoading = false;
        });
      }
    } on Exception {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: Text('Failed to load user data'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.symmetric(vertical: 08),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkGrey : AppColors.white,
                borderRadius: Constants.br16,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileAvatar(
                    placeholderImage: userData?['image'],
                    radius: 50,
                  ),
                  Constants.h16,
                  Text(
                    userData?['name'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Constants.h4,
                  Text(
                    userData?['headline'],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Constants.h16,
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to edit profile
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: Constants.br8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Constants.h24,

            // E-Tickets Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        'E-Tickets',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),

                  Constants.h16,

                  // Ticket preview (if any)
                  if (userData?['tickets'].isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? AppColors.darkGrey : AppColors.white,
                        borderRadius: Constants.br12,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData?['tickets'][0]['eventName'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                userData?['tickets'][0]['date'],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Constants.w16,
                              const Icon(Icons.confirmation_number, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                userData?['tickets'][0]['ticketType'],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  Constants.h24,

                  // Ticket action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to view all tickets
                          },
                          icon: const Icon(Icons.list),
                          label: const Text('View All Tickets'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: Constants.br8,
                            ),
                          ),
                        ),
                      ),
                      Constants.w8,
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to buy ticket
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Buy Ticket'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: Constants.br8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Constants.h32,
          ],
        ),
      ),
    );
  }
}
