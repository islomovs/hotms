import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './registration_screen.dart';
import './forgot_password_screen.dart';
import '../constants/contants.dart';
import '../constants/registration_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String? _enteredEmail;
  String? _enteredPassword;

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('$ip/api/login');
      var response = await http.post(
        url,
        body: {
          'email': _enteredEmail,
          'password': _enteredPassword,
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Success logic
        print('Login succesfully');
        print(response.body);
        print(response.statusCode);
      } else if (response.statusCode == 400) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Try again!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      } else {
        // Error handling
        print(response.body);
        print('Not Login succesfully');
        print(response.statusCode);
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
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MainTitle(
                    title: 'Welcome to Donor Aid',
                    subtitle: 'Please enter your details to continue',
                  ),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        children: [
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
                            onChanged: (value) => _enteredPassword = value,
                            validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: const Color(0xFF164863),
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFD7D7D7),
                              ),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF2B2B2B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.routeName);
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .transparent; // Transparent color on hover
                              }
                              return null; // No change for other states
                            },
                          ),
                        ),
                        child: Text(
                          'Forgot password',
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    title: 'Log in',
                    onTapFunc: () => _submitData(),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    icon: Image.asset(
                      './assets/images/google_icon.png',
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'Log in with Google',
                      style: buttonTextStyle,
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(400, 56)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Set the border radius here
                          side: const BorderSide(
                            color: Color(0xFFD7D7D7), // Set border color
                            width: 1.0, // Set border width
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  Center(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Minimize the tap target size
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors
                                        .transparent; // Transparent color on hover
                                  }
                                  return null; // No change for other states
                                },
                              ),
                            ),
                            child: Text(
                              'Sign up here',
                              style: buttonTextStyle,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegistrationScreen.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          const MainImage(),
        ],
      ),
    );
  }
}
