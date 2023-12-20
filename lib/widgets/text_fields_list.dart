import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl/intl.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';

class TextFieldsList extends StatefulWidget {
  String? enteredFName;
  String? selectedOrgan;
  String? enteredPhoneNumber;
  String? enteredAddress;
  String? enteredCity;
  String? enteredDistrict;
  String? enteredPassportNumber;
  String? enteredPINFL;
  String? selectedTypeOfDonation;
  String? enteredComment;
  String? selectedBloodGroup;
  String? selectedRHFactor;
  Widget? lastField;
  Widget? lastBtn;

  TextFieldsList({
    required this.enteredFName,
    required this.selectedOrgan,
    required this.enteredPhoneNumber,
    required this.enteredAddress,
    required this.enteredCity,
    required this.enteredDistrict,
    required this.enteredPassportNumber,
    required this.enteredPINFL,
    required this.selectedTypeOfDonation,
    required this.enteredComment,
    required this.selectedBloodGroup,
    required this.selectedRHFactor,
    required this.lastField,
    super.key,
    this.lastBtn,
  });

  @override
  State<TextFieldsList> createState() => _TextFieldsListState();
}

class _TextFieldsListState extends State<TextFieldsList> {


  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: mainColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
            // Other customizations can be here
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: widget.enteredFName,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Full name',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredFName = value,
                validator: validateName,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.enteredPhoneNumber,
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
                onChanged: (value) => widget.enteredPhoneNumber = value,
                validator: validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.enteredAddress,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredAddress = value,
                validator: validateAddress,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: widget.selectedBloodGroup?.isEmpty == true
                    ? null
                    : widget.selectedBloodGroup,
                style: originalTextStyle,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFD7D7D7),
                ),
                // focusColor: Color(0x802B2B2B),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Choose blood group';
                  }
                  return null;
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                items: ['A', 'B', 'AB', 'O'].map((String category) {
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
                    widget.selectedBloodGroup = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.enteredPassportNumber,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Passport number',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredPassportNumber = value,
                validator: validateUzbekPassportNumber,
              ),
              const SizedBox(height: 20),
              widget.lastField!,
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: widget.selectedOrgan,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Choose organ',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.selectedOrgan = value,
              ),
              // DropdownButtonFormField(
              //   value: widget.selectedOrgan?.isEmpty == true
              //       ? null
              //       : widget.selectedOrgan,
              //   style: originalTextStyle,
              //   icon: const Icon(
              //     Icons.keyboard_arrow_down,
              //     color: Color(0xFFD7D7D7),
              //   ),
              //   // focusColor: Color(0x802B2B2B),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Choose organ';
              //     }
              //     return null;
              //   },
              //   borderRadius: const BorderRadius.all(Radius.circular(8)),
              //   items: ['A', 'B', 'AB', 'O'].map((String category) {
              //     return DropdownMenuItem(
              //         value: category,
              //         child: Row(
              //           children: <Widget>[
              //             Text(category),
              //           ],
              //         ));
              //   }).toList(),
              //   onChanged: (newValue) {
              //     setState(() {
              //       widget.selectedOrgan = newValue;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'Organ',
              //     labelStyle: labelTextStyle,
              //     enabledBorder: enabledBorderParams,
              //     focusedBorder: focusedBorderParams,
              //     errorBorder: errorBorderParams,
              //     focusedErrorBorder: focusedErrorBorderParams,
              //   ),
              // ),
              const SizedBox(height: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextFormField(
                  controller: _dateController,
                  style: originalTextStyle,
                  cursorColor: const Color(0xFF2B2B2B),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    suffixIconColor: const Color(0xFFD7D7D7),
                    labelText: 'Date of birth',
                    labelStyle: labelTextStyle,
                    enabledBorder: enabledBorderParams,
                    focusedBorder: focusedBorderParams,
                    errorBorder: errorBorderParams,
                    focusedErrorBorder: focusedErrorBorderParams,
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.enteredCity,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredCity = value,
                validator: validateCity,
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: widget.enteredDistrict,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'District',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredDistrict = value,
                validator: validateDistrict,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: widget.selectedRHFactor?.isEmpty == true
                    ? null
                    : widget.selectedRHFactor=="Minus" ? "Negative" : "Positive",
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                items: ['Positive', 'Negative'].map((String category) {
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
                    widget.selectedRHFactor = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'RH factor',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.enteredPINFL,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'PINFL',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredPINFL = value,
                validator: validatePINFL,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.enteredComment,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Comments',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
                onChanged: (value) => widget.enteredComment = value,
                validator: validateComment,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
