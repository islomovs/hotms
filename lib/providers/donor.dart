import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';

class DonorId {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String role;

  DonorId({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
  });
}

class Donor {
  final String id;
  final DonorId donorId;
  final String phoneNumber;
  final String address;
  final String birthday;
  final String city;
  final String district;
  final String organDonates;
  final String passportNumber;
  final String pinfl;
  final String isApproved;
  final String bloodType;
  final String rhFactor;
  final String donationPrice;
  final String comments;
  Donor({
    required this.id,
    required this.donorId,
    required this.phoneNumber,
    required this.address,
    required this.birthday,
    required this.city,
    required this.district,
    required this.organDonates,
    required this.passportNumber,
    required this.pinfl,
    required this.isApproved,
    required this.bloodType,
    required this.rhFactor,
    required this.donationPrice,
    required this.comments,
  });
}

class Donors with ChangeNotifier {
  List<Donor> _donors = [];

  List<Donor> get donors {
    return [..._donors];
  }

  Future<List<String>> fetchDonorsHospitalsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/allHospitalsMatchingMe'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<String> stringList = List<String>.from(json.decode(response.body));
      print(stringList);
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
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<String> stringList = List<String>.from(json.decode(response.body));
      print(stringList);
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
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<String> stringList = List<String>.from(json.decode(response.body));
      print(stringList);
      return stringList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
