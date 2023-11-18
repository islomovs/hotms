// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

TextStyle originalTextStyle = const TextStyle(
  fontSize: 16,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w600,
  color: Color(0xFF2B2B2B),
);
TextStyle labelTextStyle = const TextStyle(
  fontSize: 16,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.normal,
  color: Color(0x802B2B2B),
);
TextStyle buttonTextStyle = const TextStyle(
  fontSize: 16,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w600,
  color: Color(0xFF2B2B2B),
);
InputBorder enabledBorderParams = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Color(0xFFD7D7D7),
    width: 1.0,
  ),
  borderRadius: BorderRadius.circular(8),
);
InputBorder focusedBorderParams = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Color(0xFF2B2B2B),
    width: 1.0,
  ),
  borderRadius: BorderRadius.circular(8),
);
InputBorder errorBorderParams = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Color.fromARGB(255, 255, 0, 0),
    width: 1.0,
  ),
  borderRadius: BorderRadius.circular(8),
);
InputBorder focusedErrorBorderParams = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Color.fromARGB(255, 255, 0, 0),
    width: 1.0,
  ),
  borderRadius: BorderRadius.circular(8),
);
RoundedRectangleBorder roundedCorners = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
);

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? validateConfirmPassword(String? confirmPassword, String? password) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm password cannot be empty';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name cannot be empty';
  }
  return null;
}

class MainTitle extends StatelessWidget {
  String? title;
  String? subtitle;
  MainTitle({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 48,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle!,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
            color: Color(0x802B2B2B),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class MainButton extends StatelessWidget {
  VoidCallback onTapFunc;
  String? title;
  MainButton({required this.title, required this.onTapFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(400, 56),
        backgroundColor: const Color(0xFF164863),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTapFunc,
      child: Text(
        title!,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('./assets/images/organ_login.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
