import 'dart:io';

import 'package:flutter/material.dart';

import './donor_organ_info_screen.dart';
import './hospital_donor_screen.dart';
import './hospital_info_screen.dart';
import './registration_screen.dart';
import './forgot_password_screen.dart';
import './donor_home_screen.dart';
import './patient_home_screen.dart';
import './patient_hospitals_screen.dart';
import './admin_patients_list_screen.dart';
import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import './hospital_patients_donors_screen.dart';
import './dispensary_home_screen.dart';
import './hospital_operations_screen.dart';

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

  void _loginwithgoogle() {
    Navigator.of(context).pushNamed(DispensaryHomeScreen.routeName);
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      var workingDirectory =
          '~/Desktop/myapp/home/sardorchik/Desktop/myapp/lib/screens/';

      // Change to the working directory and run the C program
      var loginResult = await Process.run(
        'bash',
        [
          '-c',
          'cd $workingDirectory && ./client localhost login $_enteredEmail $_enteredPassword'
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
          String jwtToken = output.substring(startIndex).trim();

          // Assign to a new variable and print
          extractedToken = jwtToken;
          print('Extracted JWT Token: $extractedToken');



          var infoResult = await Process.run(
            'bash',
            [
              '-c',
              'cd $workingDirectory && ./client localhost getMyInfo "$extractedToken"'
            ],
          );

          if (infoResult.exitCode == 0) {
            print('C program output: ${infoResult.stdout}');

            // Regular expression to find the role
            RegExp regExp = RegExp(r'"role":"([^"]+)"');
            var matches = regExp.allMatches(infoResult.stdout);

            if (matches.isNotEmpty) {
              // Extract the role
              extractedRole = matches.first.group(1)!;
              print('Extracted Role: $extractedRole');
            }
          } else {
            print('C program error: ${infoResult.stderr}');
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

    if (extractedRole == 'DISPENSARY') {
      Navigator.of(context).pushNamed(
        DispensaryHomeScreen.routeName,
      );
    } else if (extractedRole == 'PATIENT') {
      Navigator.of(context).pushNamed(
        PatientHomeScreen.routeName,
        arguments: extractedToken,
      );
    } else if (extractedRole == 'DONOR') {
      Navigator.of(context).pushNamed(
        DonorHomeScreen.routeName,
        arguments: extractedToken,
      );
    } else if (extractedRole == 'HOSPITAL') {
      Navigator.of(context).pushNamed(
        HospitalPatientsDonorsScreen.routeName,
        arguments: extractedToken,
      );
    } else if (extractedRole == 'ADMIN') {
      Navigator.of(context).pushNamed(
        AdminPatientsListScreen.routeName,
        arguments: extractedToken,
      );
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
                    onTapFunc: () => _login(),
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
                    onPressed: _loginwithgoogle,
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
                                  .pushNamed(DispensaryHomeScreen.routeName);
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


//   var url = Uri.parse('$ip/api/login');
    //   var response = await http.post(
    //     url,
    //     body: {
    //       'email': _enteredEmail,
    //       'password': _enteredPassword,
    //     },
    //   );

    //   // Handle the response
    //   if (response.statusCode == 200) {
    //     // Success logic
    //     print('Login succesfully');
    //     print(response.body);
    //     print(response.statusCode);
    //   } else if (response.statusCode == 400) {
    //     // ignore: use_build_context_synchronously
    //     showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //         title: const Text('Try again!'),
    //         actions: [
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.of(ctx).pop();
    //             },
    //             child: const Text('Okay'),
    //           ),
    //         ],
    //       ),
    //     );
    //   } else {
    //     // Error handling
    //     print(response.body);
    //     print('Not Login succesfully');
    //     print(response.statusCode);
    //   }
    // }