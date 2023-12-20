import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import './admin_dispenser_list_screen.dart';

class AdminEditDispenserScreen extends StatefulWidget {
  static const routeName = '/admin-edit-dispenser-screen';
  const AdminEditDispenserScreen({super.key});

  @override
  State<AdminEditDispenserScreen> createState() =>
      _AdminEditDispenserScreenState();
}

class _AdminEditDispenserScreenState extends State<AdminEditDispenserScreen> {
  String? _enteredName;
  String? _enteredEmail;
  String? _enteredPassword;

  void _saveFunc() {
    Navigator.of(context).pop();
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
            unselectedRoutes: const [AdminEditDispenserScreen.routeName],
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
