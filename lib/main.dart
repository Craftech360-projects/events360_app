import 'package:events360/core/themes/app_theme.dart';
import 'package:events360/presentation/landing/landing_screen.dart';
import 'package:events360/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Events360',
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      home: const SplashScreen(),
      routes: {
        '/landing': (context) => const LandingScreen(),
      },
    );
  }
}
