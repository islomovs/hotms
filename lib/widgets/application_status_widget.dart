import 'package:flutter/material.dart';

import '../constants/contants.dart';

class ApplicationStatusWidget extends StatefulWidget {
  bool status;
  ApplicationStatusWidget({
    required this.status,
    super.key,
  });

  @override
  State<ApplicationStatusWidget> createState() =>
      _ApplicationStatusWidgetState();
}

class _ApplicationStatusWidgetState extends State<ApplicationStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2), // Padding for border
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              widget.status == false ? const Color(0x269BBEC8) : statusIconCol,
          width: 5,
        ),
      ),
      child: CircleAvatar(
        radius: 30, // Define the radius of the circle
        backgroundColor: containerBgCol,
        child: Icon(
          size: 40,
          Icons.done,
          color:
              widget.status == false ? const Color(0x269BBEC8) : statusIconCol,
        ),
      ),
    );
  }
}
