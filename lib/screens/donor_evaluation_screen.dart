import 'dart:developer';

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
import '../widgets/medium_outlined_button.dart';
import '../providers/donor.dart';
import '../providers/dispensary.dart';

class DonorEvaluationScreen extends StatefulWidget {
  static const routeName = '/donor-evaluation-screen';

  const DonorEvaluationScreen({super.key});

  @override
  State<DonorEvaluationScreen> createState() => _DonorEvaluationScreenState();
}

class _DonorEvaluationScreenState extends State<DonorEvaluationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _items = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow1 = 3; // Initially show only 3 items
  bool? _visibility = true;

  String? _enteredName;
  String? _enteredPhoneNumber;

  bool? isDelivered = true;
  bool? isInProcess = false;
  bool? finalDecision = false;
  int smth = 1;

  void _showMore1() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow1 = _itemsToShow1 == _items.length ? 3 : _items.length;
    });
  }

  var dispensaryId;

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      // Change to the working directory and run the C program
      dispensaryId = 1;
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

  bool _isDataFetched = false;
  @override
  void didChangeDependencies() {
    Provider.of<Donors>(context)
      ..fetchMyOperations()
      ..fetchDispensaryVisitsInfo();

    super.didChangeDependencies();
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    final donor = Provider.of<Donors>(context).donorE1;
    final donorO = Provider.of<Donors>(context).donorO;
    var donorInfo = Provider.of<Donors>(context).donorOrganInfo.userId!;
    donor.isProcessing = true;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Drawer)
          SidebarTemplate(
            title: donorInfo.fullName! ?? 'Default Name',
            email: donorInfo.email! ?? 'default@email.com',
            sideBarTitles: sideBarTitlesDonor,
            sideBarListIcons: sideBarListIconsDonor,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesDonor,
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
                      title: 'Hi ${donorInfo.fullName!}!',
                      subtitle: 'Monitor and adjust your progress',
                    ),
                    const SizedBox(height: 20),
                    if ((donor.isProcessing ?? false) && donor.date != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusWidget(
                            title:
                                'Your appointment :  ${donor.date != null ? months[(int.tryParse((donor.date ?? '').split('-')[1]) ?? 1) - 1] : ''} ${donor.date != null ? (donor.date ?? '').split('-')[2] : ''}',
                            appStatusWidget: ApplicationStatusWidget(
                              status: true,
                            ),
                            status: true,
                          ),
                          StatusWidget(
                            title: 'Your data is processing',
                            appStatusWidget: ApplicationStatusWidget(
                              status: donor.isProcessing!,
                            ),
                            status: true,
                          ),
                          StatusWidget(
                            title: (donor.donorId?.isApproved ?? false)
                                ? 'Accepted'
                                : 'Rejected',
                            appStatusWidget: ApplicationStatusWidget(
                              status: true,
                            ),
                            status: true,
                          ),
                        ],
                      ),
                    if (donor.isProcessing ?? false) const SizedBox(height: 50),
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
                      child: MediumButton(
                        title: 'Send',
                        onPress: _submitData,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: containerBgCol,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Operation details',
                              style: TextStyle(
                                fontSize: 16,
                                color: containerTxtCol,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          420) /
                                      3,
                                  child: Text(
                                    'Your operation date: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blackCol,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          420) /
                                      3,
                                  child: Text(
                                    'Your operation time: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blackCol,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          420) /
                                      3,
                                  child: Text(
                                    'Your doctor: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blackCol,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          420) /
                                      3,
                                  child: Text(
                                    donorO.operationTime != null
                                        ? '${donorO.operationTime != null ? (donorO.operationTime ?? '').split(' ')[0].split('-')[2] : ''}.${donorO.operationTime != null ? (donorO.operationTime ?? '').split(' ')[0].split('-')[1] : ''}.${donorO.operationTime != null ? (donorO.operationTime ?? '').split(' ')[0].split('-')[0] : ''}'
                                        : '--.--.----',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blackCol,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          420) /
                                      3,
                                  child: Text(
                                    donorO.operationTime != null
                                        ? (donorO.operationTime ?? '')
                                            .split(' ')[1]
                                        : '--:--',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blackCol,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          420) /
                                      3,
                                  child: Text(
                                    donorO.doctorName ?? 'N/A',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blackCol,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(donorO.operationTime != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                        left: 60,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: _visibility!,
                              child: MediumOutlinedButton(
                                onPress: () {
                                  donorO.isDonorAccepted = false;

                                  print(
                                      'IS DONOR ACCEPTED $donorO.isDonorAccepted');
                                  setState(() {
                                    _visibility = false;
                                  });
                                },
                                title: 'Not agree',
                              ),
                            ),
                            const SizedBox(width: 25),
                            Visibility(
                              visible: _visibility!,
                              child: MediumButton(
                                title: 'Agree',
                                onPress: () {
                                  donorO.isDonorAccepted = true;
                                  print(
                                      'IS DONOR ACCEPTED $donorO.isDonorAccepted');
                                  setState(() {
                                    _visibility = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 40),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     HeadingWidget(
                    //       title: 'Choose Hospital',
                    //       subtitle: 'hospitals/clinics',
                    //     ),
                    //     InkWell(
                    //       onTap: _showMore1,
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             'Show more',
                    //             style: listTitleTextStyle,
                    //           ),
                    //           Icon(
                    //             Icons.keyboard_arrow_down,
                    //             size: 30,
                    //             color: patientListCol,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 40),
                    // Container(
                    //   width: double.infinity,
                    //   height: 230,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     image: const DecorationImage(
                    //       image: AssetImage('assets/images/hospital_card.png'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     childAspectRatio: 1,
                    //     crossAxisSpacing: 25,
                    //     mainAxisSpacing: 0,
                    //   ),
                    //   itemCount: _itemsToShow1,
                    //   itemBuilder: (context, index) {
                    //     return HospitalCard(
                    //       title: hospitalTitles[index],
                    //       description: hospitalDescriptions[index],
                    //     );
                    //   },
                    // ),
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
