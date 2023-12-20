import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import './login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const routeName = '/registration-screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredName;
  String? _enteredEmail;
  String? selectedValue;
  String? _password;
  String? _confirmPassword;
  String? _selectedRole;
  String? _selectedRegion;

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      // Change to the working directory and list its contents
      var listResult = await Process.run(
        'bash',
        ['-c', 'cd $workingDirectory && ls'],
      );

      if (listResult.exitCode == 0) {
        print('Listing contents of $workingDirectory:');
        print(listResult.stdout);
      } else {
        print('Error listing directory: ${listResult.stderr}');
      }

      // Change to the working directory and run the C program
      var loginResult = await Process.run(
        'bash',
        [
          '-c',
          'cd $workingDirectory && ./client $localhost signup $_enteredName $_enteredEmail $_confirmPassword $_confirmPassword $_selectedRole'
        ],
      );

      // After running the C program
      if (loginResult.exitCode == 0) {
        // Success logic
        print('C program output: ${loginResult.stdout}');

        // Extracting the JWT token
        String output = loginResult.stdout;
        String tokenPrefix = "server message: ";
        int startIndex = output.indexOf(tokenPrefix);
        if (startIndex != -1) {
          startIndex += tokenPrefix.length;
          String response = output.substring(startIndex).trim();

          if (response == "You Successfully Signed Up!") {
            Navigator.of(context).pushNamed('/');
          }
        } else {
          // Error handling
          print('C program error: ${loginResult.stderr}');
        }
      } else {
        // Error handling
        print('C program error: ${loginResult.stderr}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 120,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MainTitle(
                      title: 'Welcome to Donor Aid',
                      subtitle: 'Register to get started',
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Full name',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _enteredName = value,
                            validator: validateName,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Email address',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _enteredEmail = value,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            value: _selectedRole,
                            style: originalTextStyle,
                            // focusColor: Color(0x802B2B2B),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Choose user type';
                              }
                              return null;
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            items: [
                              'Donor',
                              'Patient',
                              'Hospital',
                              'Dispensary'
                            ].map((String category) {
                              return DropdownMenuItem(
                                  value: category,
                                  child: Row(
                                    children: <Widget>[
                                      Text(category),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'User',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            value: _selectedRegion,
                            style: originalTextStyle,
                            // focusColor: Color(0x802B2B2B),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Choose region';
                              }
                              return null;
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            items: [
                              'Tashkent',
                              'Kashkadarya',
                              'Samarkand',
                              'Bukhara'
                            ].map((String category) {
                              return DropdownMenuItem(
                                  value: category,
                                  child: Row(
                                    children: <Widget>[
                                      Text(category),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRegion = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Region',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _password = value,
                            validator: validatePassword,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _confirmPassword = value,
                            validator: (value) => validateConfirmPassword(
                                _confirmPassword, _password),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    MainButton(
                      title: 'Register',
                      onTapFunc: () => _submitData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const MainImage(),
        ],
      ),
    );
  }
}
