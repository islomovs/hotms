import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';
import './patient.dart';
import './donor.dart';

class HospitalId {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String role;

  HospitalId({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
  });
}

class Hospital {
  final String id;
  final HospitalId hospitalId;
  final String name;
  final String address;
  final String specializationOrgan;
  final String description;
  final String imageLink;
  List<Donor> patients;
  List<Donors> donors;
  Hospital({
    required this.id,
    required this.hospitalId,
    required this.address,
    required this.name,
    required this.specializationOrgan,
    required this.description,
    required this.imageLink,
    required this.patients,
    required this.donors,
  });
}

class Hospitals with ChangeNotifier {
  Future<List<String>> fetchHospitalInfo() async {
    final response = await http.get(
      Uri.parse('$ip/api/hospitals/myHospitalInfo'),
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

  Future<List<String>> fetchDonorsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/hospitals/allMyDonors'),
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

  Future<List<String>> fetchPatientsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/hospitals/allMyPatients'),
    );
    print('${response.body} patients');
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

  Future<List<String>> fetchOperationsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/hospitals/allMyOperations'),
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
      print(response.body);
      throw Exception('Failed to load data');
    }
  }

  Future<List<String>> fetchPatientsInTheQueue() async {
    final response = await http.get(
      Uri.parse('$ip/api/hospitals/allMyPatientsInTheQueue'),
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
      print(response.body);
      throw Exception('Failed to load data');
    }
  }
}
