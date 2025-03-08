import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;

  final String placeholderImage;

  const ProfileAvatar({
    super.key,
    required this.radius,
    required this.placeholderImage,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: Image.asset(
          placeholderImage,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
