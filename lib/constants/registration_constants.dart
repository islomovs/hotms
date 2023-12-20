// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:myapp/constants/constants.dart';

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
  if (value.length < 2) {
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

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  // Basic pattern: at least 10 digits, accepts optional '+' prefix
  // Adjust pattern based on your requirement
  String pattern = r'(^\+?\d{10,}$)';
  RegExp regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null; // null means validation is passed
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Address is required';
  }

  if (value.length < 5 || value.length > 100) {
    return 'Address should be between 5 and 100 characters';
  }

  // Optionally, add more specific checks here, like for the presence of numbers or street names

  return null; // Return null if the entered address is valid
}

String? validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return 'City name is required';
  }

  // Regular expression to check if the string contains only letters, spaces, and hyphens
  RegExp cityRegExp = RegExp(r'^[a-zA-Z\s-]+$');

  if (!cityRegExp.hasMatch(value)) {
    return 'Enter a valid city name';
  }

  return null; // Return null if the entered city name is valid
}

String? validateUzbekPassportNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Passport number is required';
  }

  // Regular expression for Uzbekistan passport format: Two letters followed by seven digits
  RegExp passportRegExp = RegExp(r'^[A-Z]{2}\d{7}$');

  if (!passportRegExp.hasMatch(value)) {
    return 'Enter a valid Uzbekistan passport number (e.g., AA1234567)';
  }

  return null; // Return null if the passport number is valid
}

String? validatePINFL(String? value) {
  if (value == null || value.isEmpty) {
    return 'PINFL is required';
  }

  // Regular expression to check if the string contains exactly 14 digits
  RegExp pinflRegExp = RegExp(r'^\d{14}$');

  if (!pinflRegExp.hasMatch(value)) {
    return 'Enter a valid 14-digit PINFL';
  }

  return null; // Return null if the PINFL is valid
}

String? validateDistrict(String? value) {
  if (value == null || value.isEmpty) {
    return 'District name is required';
  }

  // Regular expression to check if the string contains only letters, spaces, and possibly hyphens
  RegExp districtRegExp = RegExp(r'^[a-zA-Z\s-]+$');

  if (!districtRegExp.hasMatch(value)) {
    return 'Enter a valid district name';
  }

  return null; // Return null if the entered district name is valid
}

String? validateComment(String? value) {
  if (value == null || value.isEmpty) {
    return 'Comment is required';
  }

  // Optional: Check the length of the comment
  int minLength = 3; // Minimum comment length, adjust as needed
  int maxLength = 300; // Maximum comment length, adjust as needed

  if (value.length < minLength) {
    return 'Comment must be at least $minLength characters long';
  }

  if (value.length > maxLength) {
    return 'Comment must be less than $maxLength characters long';
  }

  // Additional checks can be added here if needed

  return null; // Return null if the comment is valid
}

String? validatePrice(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a price';
  }
  final price = double.tryParse(value);
  if (price == null) {
    return 'Please enter a valid number';
  }
  if (price < 0) {
    return 'Please enter a positive number';
  }
  // Optionally, check for maximum value or any other constraints
  // For example, if the price should not exceed $1000
  if (price > 1000) {
    return 'Price should not exceed \$1000';
  }
  // If the price is valid, return null (no error)
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
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle!,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
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
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class AcceptButton extends StatelessWidget {
  final String? title;
  Function()? onTapFunc;
  AcceptButton({
    required this.title,
    required this.onTapFunc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size((MediaQuery.of(context).size.width - 400) / 2, 56),
        backgroundColor: const Color(0xFF164863),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTapFunc,
      child: Text(
        title!,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class RejectButton extends StatelessWidget {
  VoidCallback onTapFunc;
  RejectButton({required this.onTapFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: mainColor, width: 2.0),
        minimumSize: Size((MediaQuery.of(context).size.width - 400) / 2, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTapFunc,
      child: Text(
        'Reject',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
          color: mainColor,
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
