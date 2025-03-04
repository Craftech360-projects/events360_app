import 'package:events360/core/themes/app_theme.dart';
import 'package:events360/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// CHECK THE README FILE BEFORE UPLOADING THE NEXT VERSION TO PLAY STORE

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Events360',
      home: const SplashScreen(),
    );
  }
}
