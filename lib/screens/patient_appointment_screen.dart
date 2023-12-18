import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/status_widget.dart';
import '../widgets/application_status_widget.dart';
import '../widgets/medium_button.dart';
import '../providers/patient.dart';

class PatientAppointmentScreen extends StatefulWidget {
  static const routeName = '/patient-appointment-screen';
  const PatientAppointmentScreen({super.key});

  @override
  State<PatientAppointmentScreen> createState() =>
      _PatientAppointmentScreenState();
}

class _PatientAppointmentScreenState extends State<PatientAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _items = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow1 = 3; // Initially show only 3 items

  bool? isDelivered = true;
  bool? isInProcess = false;
  bool? finalDecision = false;

  String? _enteredName;
  String? _enteredPhoneNumber;

  void _showMore1() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow1 = _itemsToShow1 == _items.length ? 3 : _items.length;
    });
  }

  void _submitData() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  void didChangeDependencies() {
    Provider.of<Patients>(context).fetchDispensaryVisits();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Drawer)
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesPatient,
            sideBarListIcons: sideBarListIconsPatient,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesPatient,
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
                      title: 'Hi Nigina Roziya!',
                      subtitle: 'Monitor and adjust your progress',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusWidget(
                          title: 'Your Application is delivered',
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
                          title: 'Accepted/Rejected',
                          appStatusWidget: ApplicationStatusWidget(
                            status: finalDecision!,
                          ),
                          status: finalDecision!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    HeadingWidget(title: 'Make an appointment'),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: originalTextStyle,
                                  cursorColor: const Color(0xFF2B2B2B),
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: labelTextStyle,
                                    enabledBorder: enabledBorderParams,
                                    focusedBorder: focusedBorderParams,
                                    errorBorder: errorBorderParams,
                                    focusedErrorBorder:
                                        focusedErrorBorderParams,
                                  ),
                                  onChanged: (value) => _enteredName = value,
                                  validator: validateName,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  style: originalTextStyle,
                                  cursorColor: const Color(0xFF2B2B2B),
                                  decoration: InputDecoration(
                                    labelText: 'Last name',
                                    labelStyle: labelTextStyle,
                                    enabledBorder: enabledBorderParams,
                                    focusedBorder: focusedBorderParams,
                                    errorBorder: errorBorderParams,
                                    focusedErrorBorder:
                                        focusedErrorBorderParams,
                                  ),
                                  onChanged: (value) => _enteredName = value,
                                  validator: validateName,
                                ),
                              ),
                            ],
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
                      child: MediumButton(title: 'Send', onPress: () {}),
                    ),
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
