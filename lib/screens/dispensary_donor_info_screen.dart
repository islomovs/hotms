import 'package:flutter/material.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/text_fields_list.dart';

class DispensaryOrganInfoScreen extends StatefulWidget {
  static const routeName = '/dispenser-organ-info-screen';
  const DispensaryOrganInfoScreen({super.key});

  @override
  State<DispensaryOrganInfoScreen> createState() =>
      _DispensaryOrganInfoScreenState();
}

class _DispensaryOrganInfoScreenState extends State<DispensaryOrganInfoScreen> {
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
  String? _enteredPrice;

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
                      HeadingWidget(title: 'Fill out Donor information'),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: originalTextStyle,
                                cursorColor: const Color(0xFF2B2B2B),
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  labelStyle: labelTextStyle,
                                  enabledBorder: enabledBorderParams,
                                  focusedBorder: focusedBorderParams,
                                  errorBorder: errorBorderParams,
                                  focusedErrorBorder: focusedErrorBorderParams,
                                ),
                                onChanged: (value) => _enteredPrice = value,
                                validator: validatePrice,
                              ),
                              const SizedBox(height: 30),
                              DropdownButtonFormField(
                                value: _selectedTypeOfDonation,
                                style: originalTextStyle,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Choose type of donation';
                                  }
                                  return null;
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                items: ['Free', 'Sell'].map((String category) {
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
                                    _selectedTypeOfDonation = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Type of donation',
                                  labelStyle: labelTextStyle,
                                  enabledBorder: enabledBorderParams,
                                  focusedBorder: focusedBorderParams,
                                  errorBorder: errorBorderParams,
                                  focusedErrorBorder: focusedErrorBorderParams,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RejectButton(onTapFunc: () {}),
                          AcceptButton(title: 'Accept', onTapFunc: () {}),
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
