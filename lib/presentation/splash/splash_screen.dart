import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/presentation/auth/auth_screen.dart';
import 'package:events360/presentation/landing/landing_screen.dart';
import 'package:events360/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Navigate to appropriate screen after animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => authProvider.isAuthenticated
                ? const LandingScreen()
                : const AuthScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 24.0,
                fontFamily: 'Satoshi',
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Events360\n',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.yellow),
                ),
                TextSpan(
                  text: 'Your one stop for all events',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
