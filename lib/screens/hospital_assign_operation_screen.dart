import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl/intl.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/medium_button.dart';
import '../widgets/medium_outlined_button.dart';
import './hospital_patients_donors_screen.dart';

class HospitalAssignOperationScreen extends StatefulWidget {
  static const routeName = '/hospital-assign-operation-screen';
  const HospitalAssignOperationScreen({super.key});

  @override
  State<HospitalAssignOperationScreen> createState() =>
      _HospitalAssignOperationScreenState();
}

class _HospitalAssignOperationScreenState
    extends State<HospitalAssignOperationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredName;
  String? _enteredRole;
  String? _selectedName;
  String? _selectedOrgan;

  bool? isDelivered = false;
  bool? isInProcess = false;
  bool? finalDecision = false;

  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: mainColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
            // Other customizations can be here
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white, // color of the main part of the picker
              onPrimary: Colors
                  .white, // color of the text and icons in the main part of the picker
              surface: mainColor, // background color of the picker
              onSurface:
                  Colors.white, // color of the text and icons on the background
            ),
            dialogBackgroundColor:
                Colors.blue[900], // background color of the dialog
            // Other customizations can be here
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
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
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesHospital,
            unselectedRoutes: const [HospitalAssignOperationScreen.routeName],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeadingWidget(
                        title: 'Assign Doctor',
                        subtitle:
                            'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
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
                              onChanged: (value) => _enteredRole = value,
                              validator: validateComment,
                            ),
                            const SizedBox(height: 20),
                            HeadingWidget(title: 'Set operation details'),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: TextFormField(
                                      controller: _dateController,
                                      style: originalTextStyle,
                                      cursorColor: const Color(0xFF2B2B2B),
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        suffixIconColor:
                                            const Color(0xFFD7D7D7),
                                        labelText: 'Date',
                                        labelStyle: labelTextStyle,
                                        enabledBorder: enabledBorderParams,
                                        focusedBorder: focusedBorderParams,
                                        errorBorder: errorBorderParams,
                                        focusedErrorBorder:
                                            focusedErrorBorderParams,
                                      ),
                                      readOnly: true,
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Flexible(
                                  flex: 1,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: TextFormField(
                                      controller: _timeController,
                                      style: originalTextStyle,
                                      cursorColor: const Color(0xFF2B2B2B),
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        suffixIconColor:
                                            const Color(0xFFD7D7D7),
                                        labelText: 'Time',
                                        labelStyle: labelTextStyle,
                                        enabledBorder: enabledBorderParams,
                                        focusedBorder: focusedBorderParams,
                                        errorBorder: errorBorderParams,
                                        focusedErrorBorder:
                                            focusedErrorBorderParams,
                                      ),
                                      readOnly: true,
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      HeadingWidget(title: 'Choose Donor'),
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        value: _selectedName,
                        style: originalTextStyle,
                        // focusColor: Color(0x802B2B2B),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Choose Donor\'s name';
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
                            _selectedName = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Donor\'s name',
                          labelStyle: labelTextStyle,
                          enabledBorder: enabledBorderParams,
                          focusedBorder: focusedBorderParams,
                          errorBorder: errorBorderParams,
                          focusedErrorBorder: focusedErrorBorderParams,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RejectButton(
                            onTapFunc: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    actionsPadding:
                                        const EdgeInsets.only(bottom: 40),
                                    contentPadding: const EdgeInsets.only(
                                      top: 60,
                                      left: 80,
                                      right: 80,
                                    ),
                                    content: Container(
                                      alignment: Alignment.center,
                                      height: 140,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure you want to reject?',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: blackCol,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      MediumOutlinedButton(
                                        title: 'No',
                                        onPress: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                      MediumButton(
                                        title: 'Yes',
                                        onPress: () {
                                          Navigator.of(context).popUntil(
                                            ModalRoute.withName(
                                                HospitalPatientsDonorsScreen
                                                    .routeName),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          AcceptButton(
                            title: 'Approve',
                            onTapFunc: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    actionsPadding:
                                        const EdgeInsets.only(bottom: 40),
                                    contentPadding: const EdgeInsets.only(
                                      top: 60,
                                      left: 80,
                                      right: 80,
                                    ),
                                    content: Container(
                                      alignment: Alignment.center,
                                      height: 140,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Are you sure you want to approve?',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: blackCol,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      MediumOutlinedButton(
                                        title: 'No',
                                        onPress: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                      MediumButton(
                                        title: 'Yes',
                                        onPress: () {
                                          Navigator.of(context).popUntil(
                                            ModalRoute.withName(
                                                HospitalPatientsDonorsScreen
                                                    .routeName),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
