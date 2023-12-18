import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  HeadingWidget({
    required this.title,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Raleway',
        ),
      ),
      subtitle?.isNotEmpty ?? false
          ? const SizedBox(height: 5)
          : const SizedBox(height: 0),
      subtitle?.isNotEmpty ?? false
          ? Text(subtitle!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Raleway',
                color: Color(0xFFA0AFC4),
              ))
          : const SizedBox(height: 0)
    ]);
  }
}
