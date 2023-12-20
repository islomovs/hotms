import 'dart:developer';

import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../constants/registration_constants.dart';

class TextFieldsListReader extends StatefulWidget {
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
  String? birthday;

  TextFieldsListReader({
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
    required this.birthday,
    super.key,
    this.lastBtn,
  });

  @override
  State<TextFieldsListReader> createState() => _TextFieldsListState();
}

class _TextFieldsListState extends State<TextFieldsListReader> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Full name',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(text: widget.enteredFName),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                controller: TextEditingController(
                  text: '+${widget.enteredPhoneNumber}',
                ),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(
                  text: widget.enteredAddress,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                controller: TextEditingController(
                  text: widget.selectedBloodGroup,
                ),
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Passport number',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(
                  text: widget.enteredPassportNumber,
                ),
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
                readOnly: true,
                controller: TextEditingController(text: widget.selectedOrgan),
                style: originalTextStyle,
                // focusColor: Color(0x802B2B2B),
                decoration: InputDecoration(
                  labelText: 'Organ',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: widget.birthday,
                ),
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Date of birth',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(
                  text: widget.enteredCity,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'District',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(
                  text: widget.enteredDistrict,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: widget.selectedRHFactor,
                ),
                style: originalTextStyle,
                // focusColor: Color(0x802B2B2B
                decoration: InputDecoration(
                  labelText: 'RH factor',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'PINFL',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(
                  text: widget.enteredPINFL,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                style: originalTextStyle,
                cursorColor: const Color(0xFF2B2B2B),
                decoration: InputDecoration(
                  labelText: 'Comments',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: enabledBorderParams,
                  errorBorder: enabledBorderParams,
                  focusedErrorBorder: enabledBorderParams,
                ),
                controller: TextEditingController(
                  text: widget.enteredComment,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
