import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  VoidCallback onPress;
  final String title;
  MediumButton({required this.title, required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(170, 56),
        backgroundColor: const Color(0xFF164863),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPress,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
