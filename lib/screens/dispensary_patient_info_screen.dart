import 'package:flutter/material.dart';
import 'package:myapp/widgets/text_fields_controller.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/text_fields_list.dart';

class DispenserPatientInfoScreen extends StatefulWidget {
  static const routeName = '/dispenser-patient-info-screen';

  const DispenserPatientInfoScreen({super.key, required this.id});

  final int id;

  @override
  State<DispenserPatientInfoScreen> createState() =>
      _DispenserPatientInfoScreenState();
}

class _DispenserPatientInfoScreenState
    extends State<DispenserPatientInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _enteredFName = TextEditingController();
  final _selectedOrgan = TextEditingController();
  final _enteredPhoneNumber = TextEditingController();
  final _enteredAddress = TextEditingController();
  final _enteredCity = TextEditingController();
  final _enteredDistrict = TextEditingController();
  final _enteredPassportNumber = TextEditingController();
  final _enteredPINFL = TextEditingController();
  final _selectedTypeOfDonation = TextEditingController();
  final _enteredComment = TextEditingController();
  final _selectedBloodGroup = TextEditingController();
  final _selectedRHFactor = TextEditingController();
  final _enteredDiagnosis = TextEditingController();
  double? _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesDispensary,
            sideBarListIcons: sideBarListIconsDispensary,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesDispensary,
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
                      HeadingWidget(title: 'Fill out Patient information'),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: TextFieldsListController(
                          enteredFName: _enteredFName,
                          selectedOrgan: _selectedOrgan,
                          enteredPhoneNumber: _enteredPhoneNumber,
                          enteredAddress: _enteredAddress,
                          enteredCity: _enteredCity,
                          enteredDistrict: _enteredDistrict,
                          enteredPassportNumber: _enteredPassportNumber,
                          enteredPINFL: _enteredPINFL,
                          selectedTypeOfDonation: _selectedTypeOfDonation,
                          enteredComment: _enteredComment,
                          selectedBloodGroup: _selectedBloodGroup,
                          selectedRHFactor: _selectedRHFactor,
                          lastField: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: originalTextStyle,
                                cursorColor: const Color(0xFF2B2B2B),
                                decoration: InputDecoration(
                                  labelText: 'Diagnosis (organ)',
                                  labelStyle: labelTextStyle,
                                  enabledBorder: enabledBorderParams,
                                  focusedBorder: focusedBorderParams,
                                  errorBorder: errorBorderParams,
                                  focusedErrorBorder: focusedErrorBorderParams,
                                ),
                                onChanged: (value) {},
                                controller: _enteredDiagnosis,
                                validator: validateComment,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Urgency rate',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  color: blackCol,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight:
                                  4.0, // Adjust track height (thickness)
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius:
                                      10.0), // Adjust thumb radius
                                  // Other properties like activeTrackColor, inactiveTrackColor, overlayColor, etc.
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: Slider(
                                    activeColor: mainColor,
                                    inactiveColor: patientListCol,
                                    value: _currentSliderValue!,
                                    min: 0,
                                    max: 2,
                                    divisions: 2,
                                    label: _currentSliderValue == 0
                                        ? 'Non Urgent'
                                        : _currentSliderValue == 1
                                        ? 'Urgent'
                                        : 'Emergency',
                                    onChanged: (value) {
                                      setState(() {
                                        _currentSliderValue = value;
                                      });
                                      print(
                                          'value changed to $_currentSliderValue');
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Non Urgent',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF9BBEC8),
                                      ),
                                    ),
                                    const Text(
                                      'Urgent',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF427D9D),
                                      ),
                                    ),
                                    Text(
                                      'Emergency',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        color: mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          dateController: TextEditingController(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RejectButton(onTapFunc: () async {
                            await rejectEvent();
                          }),
                          AcceptButton(title: 'Accept', onTapFunc: () async {
                            await acceptEvent();
                          }),
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

  Future<void> rejectEvent() async {
    dio.options.headers['Authorization'] = "Bearer $token";
    dio.options.headers['Content-Type'] = 'application/json';
    print("REJECT PRESSED");
    final response = await dio
        .put('$ip/api/dispensary/fillInPatientMedicalCard', queryParameters: {
      'patientId': widget.id,
      'address': _enteredAddress.text,
      'city': _enteredCity.text,
      'passportNumber': _enteredPassportNumber.text,
      'pinfl': _enteredPINFL.text,
      'donationPrice': 120,
      'diagnosis': _enteredDiagnosis.text,
      'birthday': '2000-12-09',
      'district': _enteredDistrict.text,
      'bloodType': _selectedBloodGroup.text,
      'rhFactor': _selectedRHFactor.text,
      'organReceives': 1,
      'comments': _enteredComment.text,
      'urgencyRate': (_currentSliderValue ?? 0).toInt(),
      'isApproved': false,
    });
    print("reject: ${response.data}");
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

  Future<void> acceptEvent() async {
    dio.options.headers['Authorization'] = "Bearer $token";
    dio.options.headers['Content-Type'] = 'application/json';
    print("ACCEPT PRESSED");
    final response = await dio
        .put('$ip/api/dispensary/fillInPatientMedicalCard', queryParameters: {
      'patientId': widget.id,
      'address': _enteredAddress.text,
      'city': _enteredCity.text,
      'passportNumber': _enteredPassportNumber.text,
      'pinfl': _enteredPINFL.text,
      'donationPrice': 120,
      'birthday': '2000-12-09',
      'diagnosis': _enteredDiagnosis.text,
      'district': _enteredDistrict.text,
      'bloodType': _selectedBloodGroup.text,
      'rhFactor': _selectedRHFactor.text,
      'organReceives': 1,
      'comments': _enteredComment.text,
      'urgencyRate': (_currentSliderValue ?? 0).toInt(),
      'isApproved': true,
    });
    print("reject: ${response.data}");
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
}
