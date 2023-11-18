import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';
import '../constants/registration_constants.dart';

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

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('$ip/api/signUp');
      var response = await http.post(
        url,
        body: {
          'fullName': _enteredName,
          'email': _enteredEmail,
          'role': _selectedRole,
          'password': _password,
          'rePassword': _confirmPassword,
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Success logic
        print('Register succesfully');
        print(response.body);
        print(response.statusCode);
      } else {
        // Error handling
        print('Not Register succesfully');
        print(response.body);
        print(response.statusCode);
      }
      Navigator.of(context).pop();
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
                            items: ['Donor', 'Patient', 'Hospital']
                                .map((String category) {
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
