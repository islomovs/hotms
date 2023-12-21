import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/screens/hospital_doctors_screen.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import './admin_patients_list_screen.dart';
import '../providers/hospitals.dart';

class HospitalAddDoctorScreen extends StatefulWidget {
  static const routeName = '/hospital-add-doctor-screen';
  const HospitalAddDoctorScreen({super.key});

  @override
  State<HospitalAddDoctorScreen> createState() =>
      _HospitalAddDoctorScreenState();
}

class _HospitalAddDoctorScreenState extends State<HospitalAddDoctorScreen> {
  String? _enteredName;
  String? _enteredEmail;
  String? _enteredRole;

  void _saveFunc() async {
    try {
      await Provider.of<Hospitals>(context)
          .createDoctor(_enteredName!, _enteredEmail!, _enteredRole!)
          .then((response) {
        if (response.statusCode == 200) {
          print('Doctor created: ${response.body}');
          Navigator.of(context).popUntil(
            ModalRoute.withName(HospitalDoctorsListScreen.routeName),
          );
        } else {
          print('Failed to create doctor. Status code: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error: $error');
      });
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
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
            sideBarTitles: sideBarTitlesHospital,
            sideBarListIcons: sideBarListIconsHospital,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesHospital,
            unselectedRoutes: const [HospitalAddDoctorScreen.routeName],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(title: 'Add doctor'),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(height: 20),
                        TextFormField(
                          style: originalTextStyle,
                          cursorColor: const Color(0xFF2B2B2B),
                          decoration: InputDecoration(
                            labelText: 'Role',
                            labelStyle: labelTextStyle,
                            enabledBorder: enabledBorderParams,
                            focusedBorder: focusedBorderParams,
                            errorBorder: errorBorderParams,
                            focusedErrorBorder: focusedErrorBorderParams,
                          ),
                          onChanged: (value) => _enteredEmail = value,
                          validator: validateComment,
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
                          onChanged: (value) => _enteredRole = value,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AcceptButton(
                            title: 'Create',
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
