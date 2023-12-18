import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';

class CreatorId {
  final int? id;
  final String? email;
  final String? password;
  final String? role;
  final String? fullName;
  // final String? imageLink; // This can be null, so it should be nullable

  CreatorId({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.fullName,
    // this.imageLink,
  });

  factory CreatorId.fromJson(Map<String, dynamic> json) {
    return CreatorId(
      id: json['id'] ?? 0, // Provide default value if null
      email: json['email'] ?? '', // Provide default value if null
      password: json['password'] ?? '', // Provide default value if null
      role: json['role'] ?? '', // Provide default value if null
      fullName: json['fullName'] ?? '', // Provide default value if null
      // imageLink: json['imageLink'], // Can be null
    );
  }
}

class DispensaryId {
  final int? id;
  final String? name;
  final CreatorId? creatorId;

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

// Main class representing each item in the JSON array
class DonorObject {
  final int? id;
  final Dispensary? dispensary;
  final Donor? donor;
  final String? date;
  final bool? isActive;

  DonorObject({
    required this.id,
    required this.dispensary,
    required this.donor,
    this.date,
    required this.isActive,
  });

  factory DonorObject.fromJson(Map<String, dynamic> json) {
    return DonorObject(
      id: json['id'],
      dispensary: Dispensary.fromJson(json['dispensaryId']),
      donor: Donor.fromJson(json['donorId']),
      date: json['date'],
      isActive: json['isActive'],
    );
  }
}

// Dispensary class to represent the 'dispensaryId' object in the JSON
class Dispensary {
  final int? id;
  final String? name;
  final User? creator;

  Dispensary({
    required this.id,
    required this.name,
    required this.creator,
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
  final String? imageLink;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.fullName,
    this.imageLink,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      fullName: json['fullName'],
      imageLink: json['imageLink'],
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
List<DonorObject> parseRecords(String jsonData) {
  final data = json.decode(jsonData) as List;
  return data.map((json) => DonorObject.fromJson(json)).toList();
}

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
class PatientObject {
  final int? id;
  final Dispensary dispensary;
  final Patient patient;
  final String? date;
  final bool? isActive;

  PatientObject({
    required this.id,
    required this.dispensary,
    required this.patient,
    this.date,
    required this.isActive,
  });

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
  List<DonorObject> donorsList = [];

  List<PatientObject> get getPatientsList => patientsList;

  List<DonorObject> get donorL {
    return [...donorsList];
  }

  List<int> patientIds = [];

  idsofPatients() {
    for (var patient in patientsList) {
      return patientIds.add(patient.id!);
    }
  }

  Future<void> fetchPatientsList(String jwtToken) async {
    if (patientsList.isEmpty) {
      final response = await http.get(
        Uri.parse('$ip/api/dispensary/allDispensaryPatients'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Raw JSON response: ${response.body}');

      // Decoding the JSON response as a List
      final List<dynamic> jsonData = json.decode(response.body) as List;

      // Assuming that PatientObject has a proper fromJson method
      patientsList = jsonData
          .where((item) => item != null) // Exclude null items
          .map((item) {
        // try {
        return PatientObject.fromJson(item);
        // } catch (e) {
        //   print('Error parsing Record: $e');
        // return PatientObject.fromJson({});
        // }
      })
          // Cast back to a list of PatientObject
          .toList();

        patientsList[0].patient?.id;

        print('HERE IS MY PATIENTS LIST: ${patientsList[0].patient?.phoneNumber}');
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    }
  }

  Future<DispensaryId> fetchDispensaryInfo(String jwtToken) async {
    final response = await http.get(
      Uri.parse('$ip/api/dispensary/myDispensaryInfo'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(
          '${DispensaryId.fromJson(jsonData).creatorId!.email}, ${DispensaryId.fromJson(jsonData).creatorId!.fullName} ');
      return DispensaryId.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<DonorObject>> fetchDonorsList(String jwtToken) async {
    final response = await http.get(
      Uri.parse('$ip/api/dispensary/allDispensaryPatients'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Print the raw response for debugging purposes
      print('Raw JSON response: ${response.body}');

      final List<dynamic> jsonData = json.decode(response.body);

      // Check for and handle a `null` item in the JSON list.
      if (jsonData.contains(null)) {
        print('Warning: The JSON data contains null items.');
      }

      donorsList = jsonData
          .where((item) => item != null) // Exclude null items
          .map((item) {
            // Provide error handling for each item
            try {
              return DonorObject.fromJson(item);
            } catch (e) {
              print('Error parsing Record: $e');
              return null;
            }
          })
          .where((item) => item != null) // Exclude items that failed to parse
          .cast<DonorObject>() // Cast back to a list of Records
          .toList();
      print('HERE IS MY DONORS LIST: $donorsList');
      return donorsList;
    } else {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }
}
