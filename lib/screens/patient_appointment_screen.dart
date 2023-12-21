import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/status_widget.dart';
import '../widgets/application_status_widget.dart';
import '../widgets/medium_button.dart';
import '../providers/patient.dart';
import '../providers/dispensary.dart';

class PatientAppointmentScreen extends StatefulWidget {
  static const routeName = '/patient-appointment-screen';

  const PatientAppointmentScreen({super.key});

  @override
  State<PatientAppointmentScreen> createState() =>
      _PatientAppointmentScreenState();
}

class _PatientAppointmentScreenState extends State<PatientAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _items = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow1 = 3; // Initially show only 3 items
  int smth = 1;

  bool? isDelivered = true;
  bool? isInProcess = false;
  bool finalDecision = false;

  String? _enteredName;
  String? _enteredPhoneNumber;

  void _showMore1() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow1 = _itemsToShow1 == _items.length ? 3 : _items.length;
    });
  }

  var dispensaryId;
  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      dispensaryId = 1;
      // Change to the working directory and run the C program
      var loginResult = await Process.run(
        'bash',
        [
          '-c',
          'cd $workingDirectory && ./client $localhost applyToDispensary $extractedToken $dispensaryId $_enteredPhoneNumber'
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
  }

  @override
  void didChangeDependencies() {
    Provider.of<Patients>(context).fetchDispensaryVisits();
    Provider.of<Patients>(context).fetchPatientInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<Patients>(context).patientInfo;
    isDelivered = patients.isApproved ?? false;
    isInProcess = !isDelivered!;
    finalDecision = isDelivered!;
    var patientInfo = Provider.of<Patients>(context).patientInfo.userId!;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Drawer)
          SidebarTemplate(
            title: patientInfo.fullName! ?? 'Default Name',
            email: patientInfo.email! ?? 'default@email.com',
            sideBarTitles: sideBarTitlesPatient,
            sideBarListIcons: sideBarListIconsPatient,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesPatient,
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Hi ${patientInfo.fullName}!',
                      subtitle: 'Monitor and adjust your progress',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusWidget(
                          title: 'Your Application is delivered',
                          appStatusWidget: ApplicationStatusWidget(
                            status: isDelivered!,
                          ),
                          status: isDelivered!,
                        ),
                        StatusWidget(
                          title: 'In Process',
                          appStatusWidget: ApplicationStatusWidget(
                            status: isInProcess!,
                          ),
                          status: isInProcess!,
                        ),
                        StatusWidget(
                          title: finalDecision ? 'Accepted' : 'Rejected',
                          appStatusWidget: ApplicationStatusWidget(
                            status: finalDecision,
                          ),
                          status: finalDecision,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    HeadingWidget(title: 'Make an appointment'),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'First Name',
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
                              labelText: 'Phone Number',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _enteredPhoneNumber = value,
                            validator: validatePhoneNumber,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MediumButton(title: 'Send', onPress: () {}),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
