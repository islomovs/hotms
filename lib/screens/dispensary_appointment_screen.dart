import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/medium_button.dart';

class DispensaryAppointmentScreen extends StatefulWidget {
  static const routeName = '/dispenser-appointment-screen';
  DispensaryAppointmentScreen({super.key});

  @override
  State<DispensaryAppointmentScreen> createState() =>
      _DispensaryAppointmentScreenState();
}

class _DispensaryAppointmentScreenState
    extends State<DispensaryAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _enteredName;
  String? _enteredPhoneNumber;

  void _submitData() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Drawer)
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesDispensary,
            sideBarListIcons: sideBarListIconsDispensary,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesDispensary,
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
                      title: 'Hi Nigina Roziya!',
                      subtitle: 'Monitor and adjust your progress',
                    ),
                    const SizedBox(height: 20),
                    HeadingWidget(title: 'Make an appointment'),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: originalTextStyle,
                                  cursorColor: const Color(0xFF2B2B2B),
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: labelTextStyle,
                                    enabledBorder: enabledBorderParams,
                                    focusedBorder: focusedBorderParams,
                                    errorBorder: errorBorderParams,
                                    focusedErrorBorder:
                                        focusedErrorBorderParams,
                                  ),
                                  onChanged: (value) => _enteredName = value,
                                  validator: validateName,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  style: originalTextStyle,
                                  cursorColor: const Color(0xFF2B2B2B),
                                  decoration: InputDecoration(
                                    labelText: 'Last name',
                                    labelStyle: labelTextStyle,
                                    enabledBorder: enabledBorderParams,
                                    focusedBorder: focusedBorderParams,
                                    errorBorder: errorBorderParams,
                                    focusedErrorBorder:
                                        focusedErrorBorderParams,
                                  ),
                                  onChanged: (value) => _enteredName = value,
                                  validator: validateName,
                                ),
                              ),
                            ],
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
