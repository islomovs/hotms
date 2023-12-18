import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';

class DonorId {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? role;

  DonorId({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.role,
  });
}

class Donor {
  final String? id;
  final DonorId? donorId;
  final String? phoneNumber;
  final String? address;
  final String? birthday;
  final String? city;
  final String? district;
  final String? organDonates;
  final String? passportNumber;
  final String? pinfl;
  final String? isApproved;
  final String? bloodType;
  final String? rhFactor;
  final String? donationPrice;
  final String? comments;

  Donor({
    this.id,
    this.donorId,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.city,
    this.district,
    this.organDonates,
    this.passportNumber,
    this.pinfl,
    this.isApproved,
    this.bloodType,
    this.rhFactor,
    this.donationPrice,
    this.comments,
  });
}

class Donors with ChangeNotifier {
  final List<Donor> _donors = [];

  List<Donor> get donors {
    return [..._donors];
  }

  Future<List<String>> fetchDonorsHospitalsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/allHospitalsMatchingMe'),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<String> stringList = List<String>.from(json.decode(response.body));
      debugPrint(stringList.toString());
      return stringList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<String>> fetchDonorInfo() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/myDonorInfo'),
      headers: {
        'Authorization': 'Bearer $donorDefaultToken',
      },
    );
    debugPrint("DONOR INFO body => ${response.body}");
    if (response.statusCode == 200) {
      debugPrint("DONOR INFO 200 => ${response.body}");
      // If the server returns a 200 OK response, parse the JSON
      List<String> stringList = List<String>.from(json.decode(response.body));
      debugPrint(stringList.toString());
      return stringList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<String>> fetchDispensaryVisitsInfo() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/allMyDispensaryVisits'),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<String> stringList = List<String>.from(json.decode(response.body));
      debugPrint(stringList.toString());
      return stringList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
