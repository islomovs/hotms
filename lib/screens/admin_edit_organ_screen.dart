import 'package:flutter/material.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';

class AdminEditOrganScreen extends StatefulWidget {
  static const routeName = '/admin-edit-organ-screen';
  const AdminEditOrganScreen({super.key});

  @override
  State<AdminEditOrganScreen> createState() => _AdminEditOrganScreenState();
}

class _AdminEditOrganScreenState extends State<AdminEditOrganScreen> {
  String? _enteredOrganName;
  String? _enteredDonorName;
  String? _selectedBloodGroup;

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
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesAdmin,
            unselectedRoutes: const [AdminEditOrganScreen.routeName],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(
                    title: 'Organ',
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
                            labelText: 'Organ name',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                          onChanged: (value) => _enteredOrganName = value,
                          validator: validateName,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: originalTextStyle,
                          cursorColor: const Color(0xFF2B2B2B),
                          decoration: InputDecoration(
                            labelText: 'Donor name',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                          onChanged: (value) => _enteredDonorName = value,
                          validator: validateName,
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          value: _selectedBloodGroup,
                          style: originalTextStyle,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFD7D7D7),
                          ),
                          // focusColor: Color(0x802B2B2B),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Choose blood group';
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
                              _selectedBloodGroup = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Blood Group',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
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
