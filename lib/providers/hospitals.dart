import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/data/HospitalOperation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';
import './patient.dart';
import './donor.dart';
import '../data/HospitalOperation.dart' as HP;

class Doctor {
  int? id;
  String? fullName;
  String? email;
  String? specialization;
  HospitalId? hospitalId;

  Doctor({
    this.id,
    required this.fullName,
    required this.email,
    required this.specialization,
    this.hospitalId,
  });

  Doctor.fromJson(dynamic json) {
    id = json['id'];
    hospitalId = json['hospitalId'] != null
        ? HospitalId.fromJson(json['hospitalId'])
        : null;
    fullName = json['fullName'];
    specialization = json['specialization'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'specialization': specialization,
    };
  }
}

class HospitalId {
  HospitalId({
    this.id,
    this.creatorId,
    this.name,
    this.address,
    this.specializationOrgans,
    this.description,
    this.imageLink,
    this.patients,
  });

  HospitalId.fromJson(dynamic json) {
    id = json['id'];
    creatorId = json['creatorId'] != null
        ? CreatorId.fromJson(json['creatorId'])
        : null;
    name = json['name'];
    address = json['address'];
    specializationOrgans = json['specializationOrgans'] != null
        ? SpecializationOrgans.fromJson(json['specializationOrgans'])
        : null;
    description = json['description'];
    imageLink = json['imageLink'];
    if (json['patients'] != null) {
      patients = [];
      json['patients'].forEach((v) {
        patients?.add(HP.Patients.fromJson(v));
      });
    }
  }
  num? id;
  CreatorId? creatorId;
  String? name;
  String? address;
  SpecializationOrgans? specializationOrgans;
  String? description;
  String? imageLink;
  List<HP.Patients>? patients;
  HospitalId copyWith({
    num? id,
    CreatorId? creatorId,
    String? name,
    String? address,
    SpecializationOrgans? specializationOrgans,
    String? description,
    String? imageLink,
    List<HP.Patients>? patients,
  }) =>
      HospitalId(
        id: id ?? this.id,
        creatorId: creatorId ?? this.creatorId,
        name: name ?? this.name,
        address: address ?? this.address,
        specializationOrgans: specializationOrgans ?? this.specializationOrgans,
        description: description ?? this.description,
        imageLink: imageLink ?? this.imageLink,
        patients: patients ?? this.patients,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (creatorId != null) {
      map['creatorId'] = creatorId?.toJson();
    }
    map['name'] = name;
    map['address'] = address;
    if (specializationOrgans != null) {
      map['specializationOrgans'] = specializationOrgans?.toJson();
    }
    map['description'] = description;
    map['imageLink'] = imageLink;
    if (patients != null) {
      map['patients'] = patients?.map((v) => v.toJson()).toList();
    }
    return map;
  }
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
  // Future<List<String>> fetchHospitalInfo() async {
  // final response =
  //     await http.get(Uri.parse('$ip/api/hospitals/myHospitalInfo'), headers: {
  //   'Authorization': 'Bearer $extractedToken',
  //   'Content-Type': 'application/json',
  // });
  // print(response.body);
  // if (response.statusCode == 200) {
  //   // If the server returns a 200 OK response, parse the JSON
  //   List<String> stringList = List<String>.from(json.decode(response.body));
  //   print(stringList);
  //   return stringList;
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // throw an exception.
  //   throw Exception('Failed to load data');
  // }
  // }

  final _dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

  List<HospitalOperation> allOperations = [];
  List<Doctor> allDoctors = [];

  Future<http.Response> createDoctor(
    String name,
    String email,
    String specialization,
  ) async {
    var url = Uri.parse('$ip/api/hospitals/createMyDoctor');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'fullName': name,
        'email': email,
        'specialization': specialization,
        'regionId': '1',
      }),
    );
    notifyListeners();
    return response;
  }

  Future<void> fetchAllOperations() async {
    print("all operation1");

    final response = await _dio.get(
      '$ip/api/hospitals/allMyOperations',
      options: Options(
        headers: {
          'Authorization': "Bearer $extractedToken",
          'Content-Type': 'application/json',
        },
      ),
    );
    print("all operation2");

    if (response.statusCode == 200) {
      final data = (response.data as List)
          .map((e) => HospitalOperation.fromJson(e))
          .toList();
      allOperations = data;
      notifyListeners();
    }
  }

  Future<void> fetchAllDoctors() async {
    print("Fetching all doctors");

    final response = await _dio.get(
      '$ip/api/hospitals/allMyDoctors',
      options: Options(
        headers: {
          'Authorization': "Bearer $extractedToken",
          'Content-Type': 'application/json',
        },
      ),
    );
    print("ALL DOCTORS: $response");

    if (response.statusCode == 200) {
      final dataD =
          (response.data as List).map((e) => Doctor.fromJson(e)).toList();
      allDoctors = dataD;
      notifyListeners();
    }
  }

  Future<void> fetchMyHospitalInfo() async {
    print("all operation1");

    final response = await _dio.get(
      '$ip/api/hospitals/myHospitalInfo',
      options: Options(
        headers: {
          'Authorization': "Bearer $extractedToken",
          'Content-Type': 'application/json',
        },
      ),
    );
    print("all operation2");

    if (response.statusCode == 200) {
      final data = (response.data as List)
          .map((e) => HospitalOperation.fromJson(e))
          .toList();
      allOperations = data;
      notifyListeners();
    }
  }

// Future<List<String>> fetchDonorsList() async {
// final response = await http.get(
//   Uri.parse('$ip/api/hospitals/allMyDonors'),
// );
// print(response.body);
// if (response.statusCode == 200) {
//   // If the server returns a 200 OK response, parse the JSON
//   List<String> stringList = List<String>.from(json.decode(response.body));
//   print(stringList);
//   return stringList;
// } else {
//   // If the server did not return a 200 OK response,
//   // throw an exception.
//   throw Exception('Failed to load data');
// }
// }

// Future<List<String>> fetchPatientsList() async {
// final response = await http.get(
//   Uri.parse('$ip/api/hospitals/allMyPatients'),
// );
// print('${response.body} patients');
// if (response.statusCode == 200) {
//   // If the server returns a 200 OK response, parse the JSON
//   List<String> stringList = List<String>.from(json.decode(response.body));
//   print(stringList);
//   return stringList;
// } else {
//   // If the server did not return a 200 OK response,
//   // throw an exception.
//   throw Exception('Failed to load data');
// }
// }

// Future<List<String>> fetchOperationsList() async {
//   // final response = await http.get(
//   //   Uri.parse('$ip/api/hospitals/allMyOperations'),
//   // );
//   // print(response.body);
//   // if (response.statusCode == 200) {
//   //   // If the server returns a 200 OK response, parse the JSON
//   //   List<String> stringList = List<String>.from(json.decode(response.body));
//   //   print(stringList);
//   //   return stringList;
//   // } else {
//   //   // If the server did not return a 200 OK response,
//   //   // throw an exception.
//   //   print(response.body);
//   //   throw Exception('Failed to load data');
//   // }
// }

// Future<List<String>> fetchPatientsInTheQueue() async {
//   final response = await http.get(
//     Uri.parse('$ip/api/hospitals/allMyPatientsInTheQueue'),
//   );
//   print(response.body);
//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, parse the JSON
//     List<String> stringList = List<String>.from(json.decode(response.body));
//     print(stringList);
//     return stringList;
//   } else {
//     // If the server did not return a 200 OK response,
//     // throw an exception.
//     print(response.body);
//     throw Exception('Failed to load data');
//   }
// }
}
