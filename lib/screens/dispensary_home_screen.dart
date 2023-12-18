import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dp;

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/status_widget.dart';
import '../widgets/number_circle_widget.dart';
import './dispensary_donor_info_screen.dart';
import './dispensary_patient_info_screen.dart';
import '../providers/dispensary.dart';

Map<String, String> patients = {
  'name': 'Saidova Saida',
  'age': '12',
  'user': 'donor',
  'subUser': 'per annum',
  'phone number': '+998(90)999-99-99',
  'city': 'Tashkent',
  'date': 'set',
  'status': 'done',
};

class DispensaryHomeScreen extends StatefulWidget {
  static const routeName = '/dispensary-home-screen';

  const DispensaryHomeScreen({super.key});

  @override
  State<DispensaryHomeScreen> createState() => _DispensaryHomeScreenState();
}

class _DispensaryHomeScreenState extends State<DispensaryHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool? isProcessing = false;

  bool? isDelivered = false;
  bool? isInProcess = false;
  bool? finalDecision = false;

  final List<String> _items = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow1 = 3; // Initially show only 3 items

  final List<String> _items2 = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow2 = 3;

  final List<String> _items3 = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow3 = 3;

  void _onSearchChanged() {
    print("Search text: ${_searchController.text}");
    // Implement your search logic here
  }

  void _showMore1() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow1 = _itemsToShow1 == _items.length ? 3 : _items.length;
    });
  }

  void _showMore2() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow2 = _itemsToShow2 == _items2.length ? 3 : _items2.length;
    });
  }

  void _showMore3() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow3 = _itemsToShow3 == _items3.length ? 3 : _items3.length;
    });
  }

  String? _dateText;
  TextEditingController _dateController = TextEditingController();
  Future<void> _selectDateTime(BuildContext context) async {
    dp.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime(2100, 12, 31),
      onConfirm: (date) {
        setState(() {
          _dateController.text = DateFormat('dd-MM-yyyy HH:mm').format(date);
          patients['date'] = _dateController.text;
        });
      },
      currentTime: DateTime.now(),
      locale: dp.LocaleType.en, // Change to your locale
      theme: dp.DatePickerTheme(
        backgroundColor: Colors.white,
        itemStyle: TextStyle(
          color: mainColor, // Adjust to match your theme color
          fontWeight: FontWeight.bold,
        ),
        doneStyle: TextStyle(color: mainColor, fontSize: 16),
        // Other customizations can be here
      ),
    );

    var workingDirectory =
        '~/Desktop/myapp/home/sardorchik/Desktop/myapp/lib/screens/';

    // Change to the working directory and run the C program
    var loginResult = await Process.run(
      'bash',
      [
        '-c',
        'cd $workingDirectory && ./client localhost assignDateForPatientsAppointment $extractedToken patientId time'
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

  @override
  void didChangeDependencies() {
    // Provider.of<DispensaryOperations>(context)
    //     .fetchDispensaryInfo(extractedToken!);
    // Provider.of<DispensaryOperations>(context).fetchDonorsList(extractedToken!);
    // Provider.of<DispensaryOperations>(context)
    // .fetchPatientsList(extractedToken!);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    final jsonData =
        '{"id": 1,"dispensaryId": {"id": 1,"name": "Dispensary 1","creatorId": {"id": 3,"email": "dispensary@mail.ru","password": "dispensary","role": "DISPENSARY","fullName": "Dispensary","imageLink": null}},"patientId": {"id": null,"userId": {"id": null,"email": "patient@mail.ru","password": "patient","role": "APPROVED_PATIENT","fullName": "Patient Patientov","imageLink": null},"phoneNumber": "998946805777","address": "Registan 5","birthday": "2023-01-01","city": "Tashkent","district": "Yunusabad","lastReceived": null,"passportNumber": "AC2679449","pinfl": "1991919191","isApproved": true,"bloodType": "3 minus","rhFactor": "Minus","isSmoker": null,"isDrinker": null,"organReceives": {"id": 1, "name": "lungs"},"urgencyRate": 5,"diagnosis": "Diagnosis cancer","comments": "bla bla bla,bla bla bla"},"date": "2023-12-18 23:55","isActive": false}';
// 2. decode the json
    var parsedJson = json.decode(jsonData);
// 3. print the type and value
    print('${jsonData[0]} : ${parsedJson['dispensaryId']}');
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    List<PatientObject> patientsEx =
        Provider.of<DispensaryOperations>(context).getPatientsList;
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
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesDispensary,
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Hi Nigina Roziya!',
                      subtitle: 'Monitor and adjust your progress',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusWidget(
                          title: 'Appointments ',
                          appStatusWidget: NumberCircleWidget(number: 67),
                          status: isDelivered!,
                        ),
                        StatusWidget(
                          title: 'Processing',
                          appStatusWidget: NumberCircleWidget(number: 75),
                          status: isInProcess!,
                        ),
                        StatusWidget(
                          title: 'Accepted/Rejected',
                          appStatusWidget: NumberCircleWidget(number: 123),
                          status: finalDecision!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingWidget(title: 'Appointments'),
                        InkWell(
                          onTap: _showMore1,
                          child: Row(
                            children: [
                              Text(
                                'Show more',
                                style: listTitleTextStyle,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: patientListCol,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DispenserHomeSectionList(
                      itemsToShow: _itemsToShow1,
                      dHSlistTile: DispenserHomeSectionListTile(
                        isProcessing: isProcessing,
                        itemsToShow: _itemsToShow1,
                        date: patientsEx[0].date.toString(),
                        time: '21:00',
                        fullName: patientsEx[0].patient.fullName,
                        age: patients['age']!,
                        phoneNumber: patientsEx[0].patient.phoneNumber,
                        city: patients['city']!,
                        userType: patientsEx[0].patient.user.role,
                        subUserType: patients['subUser']!,
                        status: patientsEx[0].patient.isApproved,
                        column4: Container(
                          alignment: Alignment.topLeft,
                          width: (MediaQuery.of(context).size.width - 620) / 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: containerBgCol,
                                minimumSize: const Size(95, 40),
                              ),
                              onPressed: () {
                                _selectDateTime(context);
                              },
                              child: Text(
                                patients['date']!,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingWidget(title: 'Processing'),
                        InkWell(
                          onTap: _showMore2,
                          child: Row(
                            children: [
                              Text(
                                'Show more',
                                style: listTitleTextStyle,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: patientListCol,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DispenserHomeSectionList(
                      itemsToShow: _itemsToShow2,
                      dHSlistTile: DispenserHomeSectionListTile(
                        isProcessing: isProcessing,
                        itemsToShow: _itemsToShow2,
                        date: '21 / 10 / 2024',
                        time: '21:00',
                        fullName: 'Saidova Saida',
                        age: '21 years',
                        phoneNumber: '+998(90)999-99-99',
                        city: 'Tashkent',
                        userType: 'donor',
                        subUserType: 'per annum',
                        status: true,
                        column4: Container(
                          alignment: Alignment.topLeft,
                          width: (MediaQuery.of(context).size.width - 620) / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '21 / 10 / 2024',
                                style: listTileTitle,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '12:30',
                                style: listTileSubTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingWidget(title: 'Accepted/Rejected'),
                        InkWell(
                          onTap: _showMore3,
                          child: Row(
                            children: [
                              Text(
                                'Show more',
                                style: listTitleTextStyle,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: patientListCol,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DispenserHomeSectionList(
                      itemsToShow: _itemsToShow3,
                      dHSlistTile: DispenserHomeSectionListTile(
                        isProcessing: isProcessing,
                        itemsToShow: _itemsToShow3,
                        date: '21 / 10 / 2024',
                        time: '21:00',
                        fullName: 'Saidova Saida',
                        age: '21 years',
                        phoneNumber: '+998(90)999-99-99',
                        city: 'Tashkent',
                        userType: 'donor',
                        subUserType: 'per annum',
                        status: true,
                        column4: Container(
                          alignment: Alignment.topLeft,
                          width: (MediaQuery.of(context).size.width - 620) / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '21 / 10 / 2024',
                                style: listTileTitle,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '12:30',
                                style: listTileSubTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DispenserHomeSectionList extends StatelessWidget {
  Widget dHSlistTile;
  DispenserHomeSectionList({
    required this.dHSlistTile,
    super.key,
    required int itemsToShow,
  }) : _itemsToShow = itemsToShow;

  final int _itemsToShow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: listHeadingBgCOl,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Text(
                    'Name',
                    style: listTitleTextStyle,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Text(
                    'User',
                    style: listTitleTextStyle,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Text(
                    'Phone number',
                    style: listTitleTextStyle,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Text(
                    'Set date',
                    style: listTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: (MediaQuery.of(context).size.width - 1000) / 4,
                  child: Text(
                    'Status',
                    style: listTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        dHSlistTile,
      ],
    );
  }
}

class DispenserHomeSectionListTile extends StatelessWidget {
  final String date;
  final String time;
  final String fullName;
  final String age;
  final String phoneNumber;
  final String city;
  final String userType;
  final String subUserType;
  bool status;
  bool? isProcessing;
  Widget column4;
  DispenserHomeSectionListTile({
    required int itemsToShow,
    required this.date,
    required this.time,
    required this.fullName,
    required this.age,
    required this.phoneNumber,
    required this.city,
    required this.userType,
    required this.subUserType,
    required this.status,
    required this.isProcessing,
    required this.column4,
    super.key,
  }) : _itemsToShow = itemsToShow;

  final int _itemsToShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _itemsToShow,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: listTileTitle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        age,
                        style: listTileSubTitle,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userType,
                        style: listTileTitle,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subUserType,
                        style: listTileSubTitle,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: (MediaQuery.of(context).size.width - 620) / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phoneNumber,
                        style: listTileTitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        city,
                        style: listTileSubTitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                column4,
                Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: containerBgCol,
                      minimumSize: const Size(95, 40),
                    ),
                    onPressed: () {},
                    child: Text(
                      status.toString(),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
