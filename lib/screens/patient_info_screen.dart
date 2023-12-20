import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';
import '../providers/patient.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/status_widget.dart';
import '../widgets/application_status_widget.dart';
import '../widgets/text_fields_list_reader.dart';

class PatientInfoScreen extends StatefulWidget {
  static const routeName = '/patient-info-screen';

  const PatientInfoScreen({super.key});

  @override
  State<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
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
  String? _birthday;

  bool? isDelivered = false;
  bool? isInProcess = false;
  bool finalDecision = false;

  @override
  void didChangeDependencies() {
    Provider.of<Patients>(context)
      ..fetchPatientInfo()
      ..fetchOperations();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<Patients>(context).patientInfo;
    final patientO = Provider.of<Patients>(context).patientO;
    _birthday = patients.birthday;
    _enteredFName = patients.userId?.fullName;
    _enteredPhoneNumber = patients.phoneNumber;
    _enteredAddress = patients.address;
    _enteredCity = patients.city;
    _enteredDistrict = patients.district;
    _enteredPassportNumber = patients.passportNumber;
    //_enteredDiagnosis = patients.;
    _enteredPINFL = patients.pinfl;
    //_selectedTypeOfDonation = patients.typeOfDonation;
    _enteredComment = patients.comments;
    _selectedBloodGroup = patients.bloodType;
    _selectedRHFactor = patients.rhFactor;
    _selectedOrgan = patients.organReceives?.name;
    _currentSliderValue =
        ((patients.urgencyRate?.toDouble() ?? 0) ~/ 5).toDouble();

    isDelivered = patients.isApproved ?? false;
    isInProcess = !isDelivered!;
    finalDecision = isDelivered!;
    var patientInfo = Provider.of<Patients>(context).patientInfo.userId!;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: patientInfo.fullName! ?? 'Default Name',
            email: patientInfo.email! ?? 'default@email.com',
            sideBarTitles: sideBarTitlesPatient,
            sideBarListIcons: sideBarListIconsPatient,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesPatient,
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
                        title: 'Check the status of your Operation',
                        subtitle: 'Monitor and adjust your progress',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusWidget(
                            title: isDelivered!
                                ? 'Your Application is delivered'
                                : 'Your Application is not delivered',
                            appStatusWidget: ApplicationStatusWidget(
                              status: isDelivered!,
                            ),
                            status: isDelivered!,
                          ),
                          StatusWidget(
                            title: 'In Process',
                            appStatusWidget: ApplicationStatusWidget(
                              status: isInProcess!,
                            ),
                            status: isInProcess!,
                          ),
                          StatusWidget(
                            title: finalDecision ? 'Accepted' : 'Rejected',
                            appStatusWidget: ApplicationStatusWidget(
                              status: finalDecision,
                            ),
                            status: finalDecision,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      HeadingWidget(title: 'Patient Information'),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: TextFieldsListReader(
                          birthday: _birthday,
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
                                  focusedBorder: enabledBorderParams,
                                  errorBorder: enabledBorderParams,
                                  focusedErrorBorder: enabledBorderParams,
                                ),
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _selectedOrgan,
                                ),
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
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
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
                        ),
                      ),
                      const SizedBox(height: 20),
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
