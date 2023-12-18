import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl/intl.dart';
import 'package:myapp/widgets/text_fields_list.dart';
import 'package:myapp/widgets/text_fields_list.dart';

import '../constants/contants.dart';
import '../constants/registration_constants.dart';

class TextFieldsListController extends StatefulWidget {
  final TextEditingController enteredFName;
  final TextEditingController selectedOrgan;
  final TextEditingController enteredPhoneNumber;
  final TextEditingController enteredAddress;
  final TextEditingController enteredCity;
  final TextEditingController enteredDistrict;
  final TextEditingController enteredPassportNumber;
  final TextEditingController enteredPINFL;
  final TextEditingController selectedTypeOfDonation;
  final TextEditingController enteredComment;
  final TextEditingController selectedBloodGroup;
  final TextEditingController selectedRHFactor;
  final TextEditingController dateController;
  final Widget? lastField;
  final Widget? lastBtn;

  const TextFieldsListController({
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
    this.lastBtn, required this.dateController,
  });

  @override
  State<TextFieldsListController> createState() =>
      _TextFieldsListControllerState();
}

class _TextFieldsListControllerState extends State<TextFieldsListController> {
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
      widget.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
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
                onChanged: (value) {},
                controller: widget.enteredFName,
                validator: validateName,
              ),
              const SizedBox(height: 20),
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
                onChanged: (value) {},
                controller: widget.enteredPhoneNumber,
                validator: validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                onChanged: (value) {},
                controller: widget.enteredAddress,
                validator: validateAddress,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: widget.selectedBloodGroup.text.isEmpty
                    ? null
                    : widget.selectedBloodGroup.text,
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
                  return DropdownMenuItem<String>(
                      value: category,
                      child: Row(
                        children: <Widget>[
                          Text(category),
                        ],
                      ));
                }).toList(),
                onChanged: (newValue) {
                  widget.selectedBloodGroup.text = newValue.toString();
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
                onChanged: (value) {},
                controller: widget.enteredPassportNumber,
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
              DropdownButtonFormField(
                value: widget.selectedOrgan.text.isEmpty
                    ? null
                    : widget.selectedOrgan.text,
                style: originalTextStyle,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFD7D7D7),
                ),
                // focusColor: Color(0x802B2B2B),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Choose organ';
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
                  widget.selectedOrgan.text = newValue.toString();
                },
                decoration: InputDecoration(
                  labelText: 'Organ',
                  labelStyle: labelTextStyle,
                  enabledBorder: enabledBorderParams,
                  focusedBorder: focusedBorderParams,
                  errorBorder: errorBorderParams,
                  focusedErrorBorder: focusedErrorBorderParams,
                ),
              ),
              const SizedBox(height: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextFormField(
                  controller: widget.dateController,
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
                onChanged: (value) {},
                controller: widget.enteredCity,
                validator: validateCity,
              ),
              const SizedBox(height: 30),
              TextFormField(
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
                onChanged: (value) {},
                controller: widget.enteredDistrict,
                validator: validateDistrict,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: widget.selectedRHFactor.text.isEmpty
                    ? null
                    : widget.selectedRHFactor.text,
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
                  widget.selectedRHFactor.text = newValue.toString();
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
                onChanged: (value) {},
                controller: widget.enteredPINFL,
                validator: validatePINFL,
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                onChanged: (value) {},
                controller: widget.enteredComment,
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
