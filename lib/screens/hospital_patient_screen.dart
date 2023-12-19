import 'package:flutter/material.dart';
import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/text_fields_list.dart';
import './hospital_assign_operation_screen.dart';

class HospitalPatientScreen extends StatefulWidget {
  static const routeName = '/hospital-patient-screen';
  final String id;
  const HospitalPatientScreen({super.key, required this.id});

  @override
  State<HospitalPatientScreen> createState() => _HospitalPatientScreenState();
}

class _HospitalPatientScreenState extends State<HospitalPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredFName;
  String? _selectedOrgan;
  String? _enteredPhoneNumber;
  String? _enteredAddress;
  String? _enteredCity;
  String? _enteredDistrict;
  String? _enteredPassportNumber;
  String? _enteredDiagnosis;
  String? _enteredPINFL;
  String? _selectedTypeOfDonation;
  String? _enteredComment;
  String? _selectedBloodGroup;
  String? _selectedRHFactor;
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
            sideBarTitles: sideBarTitlesHospital,
            sideBarListIcons: sideBarListIconsHospital,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesHospital,
            unselectedRoutes: const [
              HospitalPatientScreen.routeName,
            ],
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
                      HeadingWidget(title: 'Patient information'),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: TextFieldsList(
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
                                onChanged: (value) => _enteredDiagnosis = value,
                                validator: validateComment,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Urgency rate',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  color: blackCol,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight:
                                      4.0, // Adjust track height (thickness)
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius:
                                          10.0), // Adjust thumb radius
                                  // Other properties like activeTrackColor, inactiveTrackColor, overlayColor, etc.
                                ),
                                child: SizedBox(
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
                                    },
                                  ),
                                ),
                              ),
                              Row(
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AcceptButton(
                          title: 'Next',
                          onTapFunc: () {
                            Navigator.of(context).pushNamed(
                                HospitalAssignOperationScreen.routeName);
                          },
                        ),
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
