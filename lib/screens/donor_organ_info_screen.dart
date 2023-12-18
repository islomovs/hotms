import 'package:flutter/material.dart';
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
    List<String> donorList = await Provider.of<Donors>(context).fetchDonorInfo();
    _selectedOrgan = donorList[0];
    _enteredFName = donorList[1];
    _enteredPhoneNumber = donorList[2];
    _enteredAddress = donorList[3];
    _enteredCity = donorList[4];
    _enteredDistrict = donorList[5];
    _enteredPassportNumber = donorList[6];
    _enteredPINFL = donorList[7];
    _selectedTypeOfDonation = donorList[8];
    _enteredComment = donorList[9];
    _selectedBloodGroup = donorList[10];
    _selectedRHFactor = donorList[11];
    _enteredPrice = donorList[12];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                                controller: _priceController,
                                style: originalTextStyle,
                                cursorColor: const Color(0xFF2B2B2B),
                                enabled: _selectedTypeOfDonation == 'Free'
                                    ? false
                                    : true,
                                decoration: InputDecoration(
                                  disabledBorder: enabledBorderParams,
                                  labelText: _selectedTypeOfDonation == 'Free'
                                      ? '0.0'
                                      : 'Price',
                                  labelStyle: labelTextStyle,
                                  enabledBorder: enabledBorderParams,
                                  focusedBorder: focusedBorderParams,
                                  errorBorder: errorBorderParams,
                                  focusedErrorBorder: focusedErrorBorderParams,
                                  suffixIcon: const Icon(Icons.attach_money),
                                  suffixIconColor: patientListCol,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _enteredPrice = value;
                                  });
                                },
                                validator: validatePrice,
                              ),
                              const SizedBox(height: 30),
                              DropdownButtonFormField(
                                value: _selectedTypeOfDonation,
                                style: originalTextStyle,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFFD7D7D7),
                                ),
                                // focusColor: Color(0x802B2B2B),
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
                                  _updateTextField('Free');
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
