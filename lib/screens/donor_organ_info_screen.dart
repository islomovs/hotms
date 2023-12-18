import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/widgets/text_fields_list_reader.dart';
import 'package:provider/provider.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/text_fields_list.dart';
import '../providers/donor.dart';

class DonorOrganInfoScreen extends StatefulWidget {
  static const routeName = '/donor-organ-info-screen';

  const DonorOrganInfoScreen({super.key});

  @override
  State<DonorOrganInfoScreen> createState() => _DonorOrganInfoScreenState();
}

class _DonorOrganInfoScreenState extends State<DonorOrganInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredFName;
  String? _selectedOrgan;
  String? _enteredPhoneNumber;
  String? _enteredAddress;
  String? _enteredCity;
  String? _enteredDistrict;
  String? _enteredPassportNumber;
  String? _enteredPINFL;
  String? _selectedTypeOfDonation;
  String? _enteredComment;
  String? _selectedBloodGroup;
  String? _selectedRHFactor;
  String? _enteredPrice;
  String? _birthday;

  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _updateTextField(String? selectedValue) {
    if (selectedValue != null) {
      // Update the text field based on the dropdown selection
      _priceController.text = '';
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    await Provider.of<Donors>(context).fetchDonorInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final donor = Provider.of<Donors>(context).donorOrganInfo;
    _enteredFName = donor.userId?.fullName;
    _selectedOrgan = donor.organDonates?.name;
    _enteredPhoneNumber = donor.phoneNumber;
    _enteredAddress = donor.address;
    _enteredCity = donor.city;
    _enteredDistrict = donor.district;
    _enteredPassportNumber = donor.passportNumber;
    _enteredPINFL = donor.pinfl;
    //_selectedTypeOfDonation = donor.organDonates;
    _enteredComment = donor.comments;
    _selectedBloodGroup = donor.bloodType;
    _selectedRHFactor = donor.rhFactor;
    _enteredPrice = donor.donationPrice.toString();
    _birthday = donor.birthday;
    _updateTextField(_selectedTypeOfDonation);
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesDonor,
            sideBarListIcons: sideBarListIconsDonor,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesDonor,
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
                      HeadingWidget(title: 'Donor information'),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: TextEditingController(
                                  text: _enteredPrice,
                                ),
                                style: originalTextStyle,
                                cursorColor: const Color(0xFF2B2B2B),
                                readOnly: true,
                                decoration: InputDecoration(
                                  disabledBorder: enabledBorderParams,
                                  labelText: 'Price',
                                  labelStyle: labelTextStyle,
                                  enabledBorder: enabledBorderParams,
                                  focusedBorder: enabledBorderParams,
                                  errorBorder: enabledBorderParams,
                                  focusedErrorBorder: enabledBorderParams,
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                style: originalTextStyle,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Type of donation',
                                  labelStyle: labelTextStyle,
                                  enabledBorder: enabledBorderParams,
                                  focusedBorder: enabledBorderParams,
                                  errorBorder: enabledBorderParams,
                                  focusedErrorBorder: enabledBorderParams,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
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
