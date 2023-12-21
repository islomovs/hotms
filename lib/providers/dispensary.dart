import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/data/DonorObjectResponse.dart';
import 'package:myapp/providers/patient.dart';

import '../constants/constants.dart';

class CreatorId {
  final int id;
  final String email;
  final String password;
  final String role;
  final String fullName;
  final String? imageLink; // This can be null, so it should be nullable

  CreatorId({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.fullName,
    this.imageLink,
  });

  factory CreatorId.fromJson(Map<String, dynamic> json) {
    return CreatorId(
      id: json['id'] ?? 0,
      // Provide default value if null
      email: json['email'] ?? '',
      // Provide default value if null
      password: json['password'] ?? '',
      // Provide default value if null
      role: json['role'] ?? '',
      // Provide default value if null
      fullName: json['fullName'] ?? '',
      // Provide default value if null
      imageLink: json['imageLink'], // Can be null
    );
  }
}

class DispensaryId {
  final int id;
  final String name;
  final CreatorId creatorId;

  DispensaryId({
    required this.id,
    required this.name,
    required this.creatorId,
  });

  factory DispensaryId.fromJson(Map<String, dynamic> json) {
    return DispensaryId(
      id: json['id'], // Provide default value if null
      name: json['name'], // Provide default value if null
      creatorId:
          CreatorId.fromJson(json['creatorId']), // Provide an empty map if null
    );
  }
}

abstract class DonorOrPatient {
  final bool isPatient;
  final String? date;
  final bool? isApproved;

  DonorOrPatient({required this.isPatient, this.date, this.isApproved});
}

// Dispensary class to represent the 'dispensaryId' object in the JSON
class Dispensary {
  final int? id;
  final String? name;
  final User? creator;

  Dispensary({
    this.id,
    this.name,
    this.creator,
  });

  factory Dispensary.fromJson(Map<String, dynamic> json) {
    return Dispensary(
      id: json['id'],
      name: json['name'],
      creator: User.fromJson(json['creatorId']),
    );
  }
}

// User class to represent the 'creatorId' and 'userId' objects in the JSON
class User {
  final int? id;
  final String? email;
  final String? password;
  final String? role;
  final String? fullName;

  // final String? imageLink;

  User({
    this.id,
    this.email,
    this.password,
    this.role,
    required this.fullName,
    // this.imageLink,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      fullName: json['fullName'],
      // imageLink: json['imageLink'],
    );
  }
}

// Donor class to represent the 'donorId' object in the JSON
class Donor {
  final int? id;
  final User? user;
  final String? phoneNumber;
  final String? address;

  // ... other fields

  Donor({
    required this.id,
    required this.user,
    required this.phoneNumber,
    this.address,
    // ... other fields
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      user: User.fromJson(json['userId']),
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      // ... initialize other fields
    );
  }
}

// Function to parse the JSON data into a list of Record objects

class Patient {
  final int? id;
  final User? user;
  final String? phoneNumber;
  final String? city;
  final String? fullName;
  final bool? isApproved;

  // ... other fields

  Patient({
    this.id,
    this.user,
    this.phoneNumber,
    this.city,
    this.fullName,
    this.isApproved,

    // ... other fields
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      user: User.fromJson(json['userId']),
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      fullName: json['fullName'],
      isApproved: json['isApproved'],
      // ... initialize other fields
    );
  }
}

// Adjusted Record class for patients
class PatientObject extends DonorOrPatient {
  final int id;
  final Dispensary? dispensary;
  final Patient? patient;
  final String? date;
  final bool isActive;

  PatientObject({
    required this.id,
    required this.dispensary,
    required this.patient,
    this.date,
    required this.isActive,
  }) : super(isPatient: true, date: date, isApproved: patient?.isApproved);

  factory PatientObject.fromJson(Map<String, dynamic> json) {
    return PatientObject(
      id: json['id'],
      dispensary: Dispensary.fromJson(json['dispensaryId']),
      patient: Patient.fromJson(json['patientId']),
      date: json['date'],
      isActive: json['isActive'],
    );
  }
}

class DispensaryOperations with ChangeNotifier {
  List<PatientObject> patientsList = [];
  List<DonorObjectResponse> donorsList = [];

  List<DonorOrPatient> get getPatientAndDonors =>
      [...donorsList, ...patientsList];

  List<DonorOrPatient> get getPatientsList => patientsList;

  List<DonorOrPatient> get getDonorList => donorsList;

  List<DonorObjectResponse> get donorL {
    return donorsList;
  }

  List<int> patientIds = [];

  idsofPatients() {
    for (var patient in patientsList) {
      return patientIds.add(patient.id);
    }
  }

  Future<void> fetchPatientsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/dispensary/allDispensaryPatients'),
      headers: {
        'Authorization': 'Bearer $extractedToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Raw JSON response: ${response.body}');

      // Decoding the JSON response as a List
      final jsonData = json.decode(response.body) as List;

      // Assuming that PatientObject has a proper fromJson method
      patientsList = jsonData
          .where((item) => item != null) // Exclude null items
          .map((item) {
        // try {
        return PatientObject.fromJson(item);
        // } catch (e) {
        //   print('Error parsing Record: $e');
        //   return null;
        // }
      })
          // Exclude items that failed to parse
          // Cast back to a list of PatientObject
          .toList();

      patientsList[0].patient?.id;

      print(
          'HERE IS MY PATIENTS LIST: ${patientsList[0].patient?.phoneNumber}');
      notifyListeners();
    } else {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  Future<DispensaryId> fetchDispensaryInfo() async {
    final response = await http.get(
      Uri.parse('$ip/api/dispensary/myDispensaryInfo'),
      headers: {
        'Authorization': 'Bearer $extractedToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(
          '${DispensaryId.fromJson(jsonData).creatorId.email}, ${DispensaryId.fromJson(jsonData).creatorId.fullName} ');
      return DispensaryId.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<DonorObjectResponse>> fetchDonorsList() async {
    final dio = Dio();
    dio.options.headers['Authorization'] = "Bearer $extractedToken";
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.get(
      '$ip/api/dispensary/allDispensaryDonors',
    );

    if (response.statusCode == 200) {
      // Print the raw response for debugging purposes
      print('Raw JSON response donor: ${response.data}');

      final jsonData = response.data as List;

      // Check for and handle a `null` item in the JSON list.
      if (jsonData.contains(null)) {
        print('Warning: The JSON data contains null items.');
      }

      donorsList = jsonData
          .where((item) => item != null) // Exclude null items
          .map((item) {
        return DonorObjectResponse.fromJson(item);
      }).toList();
      print('HERE IS MY DONORS LIST: $donorsList');
      return donorsList;
    } else {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  List<OrganId> _organs = [];

  List<OrganId> get organs => _organs;
  Future<void> fetchOrgans() async {
    var url = Uri.parse(
        '$ip/api/admins/regions/allRegions'); // Replace with your API URL
    try {
      var response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _organs =
            jsonData.map((jsonItem) => OrganId.fromJson(jsonItem)).toList();
        print(jsonData);
        notifyListeners();
      } else {
        throw 'Failed to load organs';
      }
    } catch (error) {
      print('Error fetching regions: $error');
      throw error;
    }
  }
}
