import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/DonorObjectResponse.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dp;

import '../constants/constants.dart';
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

  Future<void> _selectDateTime(
      BuildContext context, DonorOrPatient model) async {
    if (model.date == null) {
      dp.DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2100, 12, 31),
        onConfirm: (date) async {
          print("date99: ${DateFormat('yyyy-MM-ddTHH:mm').format(date)}");
          final time = DateFormat('yyyy-MM-ddTHH:mm').format(date);
          dio.options.headers['Authorization'] = "Bearer $extractedToken";
          dio.options.headers['Content-Type'] = 'application/json';
          if (model is PatientObject) {
            final patientModel = model;
            final response = await dio.post(
                '$ip/api/dispensary/assignDateForPatientsAppointment',
                queryParameters: {
                  'patientId': patientModel.patient?.id,
                  'time': time,
                });
            print("response setDate: ${response.data}");
          } else {
            final donorModel = model as DonorObjectResponse;
            final response = await dio.post(
                '$ip/api/dispensary/assignDateForDonorsAppointment',
                queryParameters: {
                  'donorId': donorModel.donorId?.id,
                  'time': time,
                });
            print("response setDate: ${response.data}");
          }
        },
        currentTime: DateTime.now(),
        locale: dp.LocaleType.en,
        // Change to your locale
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
    }

    var workingDirectory =
        '~/Desktop/myapp/home/sardorchik/Desktop/myapp/lib/screens/';

    // Change to the working directory and run the C program
    var loginResult = await Process.run(
      'bash',
      [
        '-c',
        'cd $workingDirectory && ./client $localhost assignDateForPatientsAppointment $extractedToken patientId time'
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
    Provider.of<DispensaryOperations>(context, listen: false)
        .fetchDispensaryInfo();
    Provider.of<DispensaryOperations>(context, listen: false).fetchDonorsList();
    Provider.of<DispensaryOperations>(context, listen: false)
        .fetchPatientsList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    const jsonData =
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
    final List<DonorOrPatient> rxPatients =
        Provider.of<DispensaryOperations>(context).getPatientAndDonors;
    // print("data: $rxPatients");
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
                    if (rxPatients.isNotEmpty)
                      DispenserHomeSectionList(
                        itemsToShow: _itemsToShow1,
                        dHSlistTile: DispenserHomeSectionListTile(
                          models: rxPatients
                              .where((element) =>
                                  element.date == null &&
                                  element.isApproved == null)
                              .toList(),
                          isProcessing: isProcessing,
                          itemsToShow: _itemsToShow1,
                          status: rxPatients[0].isApproved ?? false,
                          onSetDate: (DonorOrPatient value) {
                            _selectDateTime(context, value);
                          },
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
                        models: rxPatients
                            .where((element) =>
                                element.isApproved == null &&
                                element.date != null)
                            .toList(),
                        isProcessing: isProcessing,
                        itemsToShow: _itemsToShow2,
                        status: true,
                        onSetDate: (DonorOrPatient value) {
                          _selectDateTime(context, value);
                        },
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
                        models: (rxPatients)
                            .where((element) =>
                                element.date != null &&
                                element.isApproved != null)
                            .toList(),
                        isProcessing: isProcessing,
                        itemsToShow: _itemsToShow3,
                        status: true,
                        onSetDate: (DonorOrPatient value) {
                          _selectDateTime(context, value);
                        },
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
  });

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
  bool status;
  bool? isProcessing;
  final ValueChanged<DonorOrPatient> onSetDate;
  final List<DonorOrPatient> models;

  DispenserHomeSectionListTile({
    required int itemsToShow,
    required this.status,
    required this.isProcessing,
    super.key,
    required this.models,
    required this.onSetDate,
  });

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
        itemCount: models.length,
        itemBuilder: (context, index) {
          if (models[index] is PatientObject) {
            final model = models[index] as PatientObject;
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
                          model.patient?.user?.fullName ?? '',
                          style: listTileTitle,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.patient?.id.toString() ?? '',
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
                          model.patient?.user?.role ?? '',
                          style: listTileTitle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.patient?.user?.email ?? '',
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
                          model.patient?.phoneNumber ?? '',
                          style: listTileTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.patient?.city ?? '',
                          style: listTileSubTitle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          onSetDate(model);
                        },
                        child: Text(
                          model.date ?? 'Set',
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
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: model.isApproved == null
                            ? model.date == null
                                ? Colors.yellow
                                : null
                            : model.isApproved == true
                                ? Colors.blue
                                : Colors.red,
                        minimumSize: const Size(95, 40),
                      ),
                      onPressed: () {
                        if (model.date != null && model.isApproved == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DispenserPatientInfoScreen(
                                  id: model.patient?.id ?? 0,
                                ),
                              ));
                        }
                      },
                      child: Text(
                        model.isApproved == null
                            ? model.date == null
                                ? "Waiting"
                                : "Edit"
                            : model.isApproved == true
                                ? "Accepted"
                                : "Rejected",
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
          } else if (models[index] is DonorObjectResponse) {
            final model = models[index] as DonorObjectResponse;
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
                          model.donorId?.userId?.fullName ?? '',
                          style: listTileTitle,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.donorId?.id.toString() ?? '',
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
                          model.donorId?.userId?.role ?? '',
                          style: listTileTitle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.donorId?.userId?.email ?? '',
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
                          model.donorId?.phoneNumber ?? '',
                          style: listTileTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "",
                          style: listTileSubTitle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          onSetDate(model);
                        },
                        child: Text(
                          model.date ?? 'Set',
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
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: model.isApproved == null
                            ? model.date == null
                                ? Colors.yellow
                                : null
                            : model.isApproved == true
                                ? Colors.blue
                                : Colors.red,
                        minimumSize: const Size(95, 40),
                      ),
                      onPressed: () {
                        if (model.date != null && model.isApproved == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DispensaryOrganInfoScreen(
                                  id: model.donorId?.id?.toInt() ?? 0,
                                ),
                              ));
                        }
                      },
                      child: Text(
                        model.isApproved == null
                            ? model.date == null
                                ? "Waiting"
                                : "Edit"
                            : model.isApproved == true
                                ? "Accepted"
                                : "Rejected",
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
          }
        },
      ),
    );
  }
}
