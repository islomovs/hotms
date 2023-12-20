import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import './admin_hospitals_list_screen.dart';

class AdminAddHospitalScreen extends StatefulWidget {
  static const routeName = '/admin-add-hospital-screen';
  const AdminAddHospitalScreen({super.key});

  @override
  State<AdminAddHospitalScreen> createState() => _AdminAddHospitalScreenState();
}

class _AdminAddHospitalScreenState extends State<AdminAddHospitalScreen> {
  String? _enteredName;
  String? _selectedOrgan;
  String? _enteredPassword;

  void _saveFunc() {
    Navigator.of(context).popUntil(
      ModalRoute.withName(AdminHospitalsListScreen.routeName),
    );
  }

  int smth = 1;
  void _submitData() async {
    var workingDirectory =
        '~/Desktop/myapp/home/sardorchik/Desktop/myapp/lib/screens/';

    // Change to the working directory and run the C program
    var loginResult = await Process.run(
      'bash',
      [
        '-c',
        'cd $workingDirectory && ./client localhost adminCreateHospital $extractedToken $_enteredName $_selectedOrgan $_enteredPassword'
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

    Navigator.of(context).popUntil(
      ModalRoute.withName(AdminHospitalsListScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesPatient,
            sideBarListIcons: sideBarListIconsPatient,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesPatient,
            unselectedRoutes: const [AdminAddHospitalScreen.routeName],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(
                    title: 'Hospital',
                    subtitle:
                        'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
                  ),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: originalTextStyle,
                          cursorColor: const Color(0xFF2B2B2B),
                          decoration: InputDecoration(
                            labelText: 'Hospital Name',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                          onChanged: (value) => _enteredName = value,
                          validator: validateName,
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          value: _selectedOrgan,
                          style: originalTextStyle,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFD7D7D7),
                          ),
                          // focusColor: Color(0x802B2B2B),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Choose organ';
                            }
                            return null;
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          items: ['A', 'B', 'AB', 'O'].map((String category) {
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
                              _selectedOrgan = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Selected Organ',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: originalTextStyle,
                          cursorColor: const Color(0xFF2B2B2B),
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                          onChanged: (value) => _enteredPassword = value,
                          validator: validateAddress,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AcceptButton(
                            title: 'Save',
                            onTapFunc: _saveFunc,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
