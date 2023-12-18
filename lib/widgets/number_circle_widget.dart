import 'package:flutter/material.dart';
import 'package:myapp/constants/contants.dart';

class NumberCircleWidget extends StatelessWidget {
  final int number;

  NumberCircleWidget({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65, // Set the width and height to your desired size
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 5,
          color: statusIconCol,
        ),
      ),
      child: Center(
        child: Text(
          '$number', // The number to be displayed
          style: TextStyle(
            fontSize: 24, // Adjust the font size as needed
            color: blackCol, // Text color
            fontWeight: FontWeight.w600, // Font weight as bold
          ),
        ),
      ),
    );
  }
}
