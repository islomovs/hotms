import 'package:flutter/material.dart';

import '../constants/constants.dart';

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
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFDDF2FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          Text(
            btnTitle,
            style: TextStyle(fontSize: 12, color: mainColor),
          ),
        ],
      ),
    );
  }
}
