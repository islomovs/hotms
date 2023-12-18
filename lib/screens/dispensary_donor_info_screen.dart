import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/text_fields_controller.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/text_fields_list.dart';

class DispensaryOrganInfoScreen extends StatefulWidget {
  static const routeName = '/dispenser-organ-info-screen';

  final int id;

  const DispensaryOrganInfoScreen({super.key, required this.id});

  @override
  State<DispensaryOrganInfoScreen> createState() =>
      _DispensaryOrganInfoScreenState();
}

class _DispensaryOrganInfoScreenState extends State<DispensaryOrganInfoScreen> {
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
  final _enteredPrice = TextEditingController();
  final _enteredBirthday = TextEditingController();

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
                                onChanged: (value) {},
                                controller: _enteredPrice,
                                validator: validatePrice,
                              ),
                              const SizedBox(height: 30),
                              DropdownButtonFormField(
                                value: _selectedTypeOfDonation.text.isEmpty
                                    ? null
                                    : _selectedTypeOfDonation.text,
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
                                  _selectedTypeOfDonation.text =
                                      newValue.toString();
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
                          dateController: _enteredBirthday,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RejectButton(
                            onTapFunc: () async {
                              dio.options.headers['Authorization'] =
                                  "Bearer $token";
                              dio.options.headers['Content-Type'] =
                                  'application/json';
                              print("REJECT PRESSED");

                              final response = await dio.put(
                                  '$ip/api/dispensary/fillInDonorMedicalCard',
                                  queryParameters: {
                                    'donorId': widget.id,
                                    'address': _enteredAddress.text,
                                    'city': _enteredCity.text,
                                    'passportNumber':
                                        _enteredPassportNumber.text,
                                    'pinfl': _enteredPINFL.text,
                                    'donationPrice': _enteredPrice.text,
                                    'birthday': '2000-12-09',
                                    'bloodType': _selectedBloodGroup.text,
                                    'district': _enteredDistrict.text,
                                    'rhFactor': _selectedRHFactor.text,
                                    'organDonates': 1,
                                    'comments': _enteredComment.text,
                                    'isApproved': false,
                                  });
                              print("reject: ${response.data}");
                              if (response.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Done :)")));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Something went wrong :(")));
                              }
                            },
                          ),
                          AcceptButton(
                            title: 'Accept',
                            onTapFunc: () async {
                              dio.options.headers['Authorization'] =
                                  "Bearer $token";
                              dio.options.headers['Content-Type'] =
                                  'application/json';
                              print("ACCEPT PRESSED");

                              final response = await dio.put(
                                  '$ip/api/dispensary/fillInDonorMedicalCard',
                                  queryParameters: {
                                    'donorId': widget.id,
                                    'address': _enteredAddress.text,
                                    'city': _enteredCity.text,
                                    'passportNumber':
                                    _enteredPassportNumber.text,
                                    'pinfl': _enteredPINFL.text,
                                    'donationPrice': _enteredPrice.text,
                                    'birthday': '2000-12-09',
                                    'bloodType': _selectedBloodGroup.text,
                                    'district': _enteredDistrict.text,
                                    'rhFactor': _selectedRHFactor.text,
                                    'organDonates': 1,
                                    'comments': _enteredComment.text,
                                    'isApproved': true,
                                  });
                              print("response $response");
                              if (response.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Done :)")));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Something went wrong :(")));
                              }
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
