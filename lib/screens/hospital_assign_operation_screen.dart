import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl/intl.dart';
import 'package:myapp/data/AllDonorsResponse.dart';
import 'package:myapp/data/AllMyDoctorsResponse.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/medium_button.dart';
import '../widgets/medium_outlined_button.dart';
import './hospital_patients_donors_screen.dart';

class HospitalAssignOperationScreen extends StatefulWidget {
  static const routeName = '/hospital-assign-operation-screen';
  final String id;

  const HospitalAssignOperationScreen({super.key, required this.id});

  @override
  State<HospitalAssignOperationScreen> createState() =>
      _HospitalAssignOperationScreenState();
}

class _HospitalAssignOperationScreenState
    extends State<HospitalAssignOperationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredName;
  String? _enteredRole;
  String? _selectedDonorName;
  String? _selectedDoctorName;
  AllDoctorsResponse? _selectedDoctor;
  AllDonorsResponse? _selectedDonor;
  String? _selectedOrgan;

  bool? isDelivered = false;
  bool? isInProcess = false;
  bool? finalDecision = false;

  DateTime? _dateController;
  TimeOfDay? _time;

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
        _dateController = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return child!;
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              // color of the main part of the picker
              onPrimary: Colors.white,
              // color of the text and icons in the main part of the picker
              surface: mainColor,
              // background color of the picker
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
        _time = picked;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  int smth = 1;
  void _submitData() async {
    // Change to the working directory and run the C program
    var loginResult = await Process.run(
      'bash',
      [
        '-c',
        'cd $workingDirectory && ./client $localhost appointOperationToAnyPatient $extractedToken "doctorName" "doctorRole" $smth $smth $smth'
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
            'cd $workingDirectory && ./client $localhost getMyInfo "$extractedToken"'
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
                      DropdownButtonFormField(
                        value: _selectedDoctorName,
                        style: originalTextStyle,
                        // focusColor: Color(0x802B2B2B),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Choose Doctor\'s name';
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
                            _selectedDoctorName = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Doctor\'s name',
                          labelStyle: labelTextStyle,
                          enabledBorder: enabledBorderParams,
                          focusedBorder: focusedBorderParams,
                          errorBorder: errorBorderParams,
                          focusedErrorBorder: focusedErrorBorderParams,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                            FutureBuilder(
                              future: dio.get('$ip/api/hospitals/allMyDoctors',
                                  options: Options(headers: {
                                    'Authorization': "Bearer $extractedToken",
                                    'Content-Type': 'application/json'
                                  })),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final response = snapshot.data;
                                  final List<AllDoctorsResponse> doctors = [];

                                  if (response?.statusCode == 200) {
                                    final models = (response?.data as List).map(
                                        (e) => AllDoctorsResponse.fromJson(e));
                                    doctors.addAll(models);
                                  }
                                  return DropdownButtonFormField(
                                    value: _selectedDoctorName,
                                    style: originalTextStyle,
                                    // focusColor: Color(0x802B2B2B),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Choose Doctor\'s name';
                                      }
                                      return null;
                                    },
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    items: doctors.map((category) {
                                      return DropdownMenuItem<String>(
                                        value: category.fullName ?? '',
                                        child: Row(
                                          children: <Widget>[
                                            Text(category.fullName ?? ''),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedDoctorName = newValue;
                                      });
                                      _selectedDoctor = doctors
                                          .where((element) =>
                                              element.fullName ==
                                              _selectedDoctorName)
                                          .toList()[0];
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Doctor\'s name',
                                      labelStyle: labelTextStyle,
                                      enabledBorder: enabledBorderParams,
                                      focusedBorder: focusedBorderParams,
                                      errorBorder: errorBorderParams,
                                      focusedErrorBorder:
                                          focusedErrorBorderParams,
                                    ),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            // TextFormField(
                            //   style: originalTextStyle,
                            //   cursorColor: const Color(0xFF2B2B2B),
                            //   decoration: InputDecoration(
                            //     labelText: 'Full name',
                            //     labelStyle: labelTextStyle,
                            //     enabledBorder: enabledBorderParams,
                            //     focusedBorder: focusedBorderParams,
                            //     errorBorder: errorBorderParams,
                            //     focusedErrorBorder: focusedErrorBorderParams,
                            //   ),
                            //   onChanged: (value) => _enteredName = value,
                            //   validator: validateName,
                            // ),
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
                                      controller: TextEditingController(
                                          text: DateFormat('dd-MM-yyyy').format(
                                              _dateController ??
                                                  DateTime.now())),
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
                                      controller: TextEditingController(
                                          text:
                                              '${_time?.hour ?? '00'}:${_time?.minute ?? '00'}'),
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
                      FutureBuilder(
                        future: dio.get('$ip/api/hospitals/allMyDonors',
                            options: Options(headers: {
                              'Authorization': "Bearer $extractedToken",
                              'Content-Type': 'application/json'
                            })),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final response = snapshot.data;
                            final List<AllDonorsResponse> donors = [];

                            if (response?.statusCode == 200) {
                              final models = (response?.data as List)
                                  .map((e) => AllDonorsResponse.fromJson(e));
                              donors.addAll(models);
                            }

                            return DropdownButtonFormField(
                              value: _selectedDonorName,
                              style: originalTextStyle,
                              // focusColor: Color(0x802B2B2B),
                              validator: (value) {
                                if (value == null) {
                                  return 'Choose Donor\'s name';
                                }
                                return null;
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              items: donors.map((category) {
                                return DropdownMenuItem<String>(
                                  value:
                                      category.donorId?.userId?.fullName ?? '',
                                  child: Row(
                                    children: <Widget>[
                                      Text(category.donorId?.userId?.fullName ??
                                          ''),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedDonorName = newValue;
                                });
                                _selectedDonor = donors
                                    .where((element) =>
                                        element.donorId?.userId?.fullName ==
                                        _selectedDonorName)
                                    .toList()[0];
                              },
                              decoration: InputDecoration(
                                labelText: 'Donor\'s name',
                                labelStyle: labelTextStyle,
                                enabledBorder: enabledBorderParams,
                                focusedBorder: focusedBorderParams,
                                errorBorder: errorBorderParams,
                                focusedErrorBorder: focusedErrorBorderParams,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
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
                                          Navigator.of(ctx).pop();
                                          rejectEvent();
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
                                          Navigator.of(ctx).pop();
                                          approveEvent();
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

  Future<void> approveEvent() async {
    try {
      final response = await dio.post(
        '$ip/api/hospitals/appointOperationToAnyPatient',
        options: Options(headers: {
          'Authorization': "Bearer $extractedToken",
          'Content-Type': 'application/json'
        }),
        queryParameters: {
          'doctorId': _selectedDoctor?.id,
          'time':
              '${DateFormat('yyyy-MM-dd').format(_dateController ?? DateTime.now())}T${formatNumber(_time?.hour ?? 0)}:${formatNumber(_time?.minute ?? 0)}',
          'patientId': widget.id,
          'donorId': _selectedDonor?.donorId?.id,
        },
      );
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green, content: Text("Done 🎉")));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Something went wrong 😢")));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }

  Future<void> rejectEvent() async {
    try {
      final response = await dio.delete(
        '$ip/api/hospitals/cancelOperation',
        options: Options(headers: {
          'Authorization': "Bearer $extractedToken",
          'Content-Type': 'application/json'
        }),
        queryParameters: {
          'operationId': widget.id,
        },
      );
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green, content: Text("Done 🎉")));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Something went wrong 😢")));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }

  String formatNumber(int num) {
    if (num < 9) {
      return '0$num';
    } else {
      return num.toString();
    }
  }
}
