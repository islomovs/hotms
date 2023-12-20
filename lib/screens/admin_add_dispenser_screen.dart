import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import './admin_dispenser_list_screen.dart';

class AdminAddDispensersScreen extends StatefulWidget {
  static const routeName = '/admin-add-dispenser-screen';
  const AdminAddDispensersScreen({super.key});

  @override
  State<AdminAddDispensersScreen> createState() =>
      _AdminAddDispensersScreenState();
}

class _AdminAddDispensersScreenState extends State<AdminAddDispensersScreen> {
  String? _enteredName;
  String? _enteredEmail;
  String? _enteredPassword;

  void _saveFunc() {
    Navigator.of(context).popUntil(
      ModalRoute.withName(AdminDispensersListScreen.routeName),
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
        'cd $workingDirectory && ./client localhost adminCreateOrgan $extractedToken $_enteredName'
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
    print('BUTTON IS TAPPED');
    Navigator.of(context).pushNamed(AdminDispensersListScreen.routeName);
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
            sideBarTitles: sideBarTitlesAdmin,
            sideBarListIcons: sideBarListIconsAdmin,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesAdmin,
            unselectedRoutes: const [AdminAddDispensersScreen.routeName],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(
                    title: 'Dispenser',
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
                            labelText: 'Name',
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
                        TextFormField(
                          style: originalTextStyle,
                          cursorColor: const Color(0xFF2B2B2B),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                          onChanged: (value) => _enteredEmail = value,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
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
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AcceptButton(
                            title: 'Save',
                            onTapFunc: _submitData,
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
