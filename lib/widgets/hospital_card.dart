import 'package:flutter/material.dart';

import '../constants/constants.dart';
import './request_button.dart';

class HospitalCard extends StatelessWidget {
  final String title;
  final String description;
  final String? img;
  VoidCallback onTap;

  HospitalCard({
    required this.title,
    required this.description,
    required this.onTap,
    this.img,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: img != null
              ? Image.network(
                  'http://161.35.75.184:1234/$img',
                  fit: BoxFit.cover,
                  height: 80,
                  width: 320,
                )
              : Image.asset(
                  './assets/images/hospital_card.png',
                  fit: BoxFit.cover,
                  height: 80,
                  width: 320,
                ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
        const SizedBox(height: 10),
        Text(description),
        const SizedBox(height: 20),
        RequestButton(
          btnTitle: 'Apply',
          icon: Icon(
            Icons.done,
            color: mainColor,
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
