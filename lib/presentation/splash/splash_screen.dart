import 'dart:async';

import 'package:events360/presentation/home/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            var fadeAnimation =
                Tween<double>(begin: begin, end: end).animate(animation);
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 1000),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 24.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Events360\n',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                  TextSpan(
                    text: 'by Craftech360',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
