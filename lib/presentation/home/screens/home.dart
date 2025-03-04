import 'package:events360/core/assets/app_images.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/presentation/events/event_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox.expand(
          child: Image.asset(
            AppImages.appBgImg,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to Events360',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EventScreen()));
                  },
                  child: Text(
                    'View Events',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.black,
                        ),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
