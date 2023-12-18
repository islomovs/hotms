import 'package:flutter/material.dart';

import '../constants/contants.dart';

class RequestButton extends StatelessWidget {
  final String btnTitle;
  Icon? icon;
  VoidCallback? onTap;
  RequestButton({
    required this.btnTitle,
    required this.onTap,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDDF2FD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            if (icon != null) icon!,
            Text(
              btnTitle,
              style: TextStyle(fontSize: 12, color: mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
