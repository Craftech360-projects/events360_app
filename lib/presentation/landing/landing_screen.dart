import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/presentation/home/home.dart';
import 'package:events360/presentation/profile/profile_screen.dart';
import 'package:events360/presentation/speaker/speaker_screen.dart';
import 'package:events360/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load event data when landing screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).loadEventData();
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const SpeakerScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.25),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontSize: 12),
            iconSize: 23,
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: AppColors.blue,
            unselectedItemColor: AppColors.lightGrey,
            backgroundColor: isDarkMode ? AppColors.greyDark : AppColors.white,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mic),
                label: 'Speakers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
