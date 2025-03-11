import 'package:events360/core/themes/app_theme.dart';
import 'package:events360/infrastructure/supabase_service.dart';
import 'package:events360/presentation/landing/landing_screen.dart';
import 'package:events360/presentation/splash/splash_screen.dart';
import 'package:events360/providers/auth_provider.dart';
import 'package:events360/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.initialize();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(prefs)),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Events360',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      home: const SplashScreen(),
      routes: {
        '/landing': (context) => const LandingScreen(),
      },
    );
  }
}
