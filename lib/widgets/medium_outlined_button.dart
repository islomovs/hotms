import 'package:flutter/material.dart';

import '../constants/contants.dart';

class MediumOutlinedButton extends StatelessWidget {
  VoidCallback onPress;
  final String title;
  MediumOutlinedButton({
    required this.onPress,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(170, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            width: 2,
            color: mainColor,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: mainColor,
          ),
        ));
  }
}
