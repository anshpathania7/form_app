import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  final String name;
  const GreetingText({Key? key, required this.name}) : super(key: key);

  String get _getTime {
    final currentHour = DateTime.now().toLocal().hour;
    if (currentHour >= 5 && currentHour < 12) {
      return 'Morning';
    }
    if (currentHour >= 12 && currentHour < 16) {
      return 'Afternoon';
    }
    if (currentHour >= 16 && currentHour < 20) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  final TextStyle _boldText = const TextStyle(
    color: Colors.black87,
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good " + _getTime,
          style: _boldText,
        ),
        Text(
          name,
          style: _boldText,
        ),
      ],
    );
  }
}
