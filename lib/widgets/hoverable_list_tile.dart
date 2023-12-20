import 'package:flutter/material.dart';

import '../constants/constants.dart';

class HoverableListTile extends StatelessWidget {
  final bool isHovered;
  final bool isSelected;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const HoverableListTile({
    required this.isHovered,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? mainColor
            : (isHovered ? mainColor : Colors.transparent),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: onTap,
        enableFeedback: false,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: ListTile(
          hoverColor: Colors.transparent,
          leading: Icon(
            icon,
            color: const Color(0xFFFFFFFF),
          ),
          title: Text(
            title,
            style: sideBarListTextStyle,
          ),
        ),
      ),
    );
  }
}
