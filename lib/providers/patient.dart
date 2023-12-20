import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import 'donor.dart';

class Region {
  int? id;
  String? name;

  Region({
    this.id,
    this.name,
  });

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Patients with ChangeNotifier {
  late final List<OrganAllHospitals> _patientH = [];

  List<OrganAllHospitals> get patientH => _patientH;

  late final List<DonorE1> _patientDis = [];

  List<DonorE1> get patientDis => _patientDis;

  late final List<PaitientHospitalAplied> _patientApplied = [];

  List<PaitientHospitalAplied> get patientApplied => _patientApplied;

  late final List<PaitientHospitalAplied> _patientAppliedUser = [];

  List<PaitientHospitalAplied> get patientAppliedUser => _patientAppliedUser;

  late Donor _patientInfo = Donor();

  Donor get patientInfo => _patientInfo;

  late DonorOperations _patientO = DonorOperations();

  DonorOperations get patientO => _patientO;

  late List<Region> _regions;
  List<Region> get regions => _regions;

  Future<List<Region>> fetchRegions() async {
    final response = await http.get(
      Uri.parse('$ip/api/admins/regions/allRegions'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientDis.clear();
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _regions.add(Region.fromJson(json.decode(response.body)[i]));
      }
      notifyListeners();
      return _regions;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<Donor> fetchPatientInfo() async {
    final response =
        await http.get(Uri.parse('$ip/api/patients/myInfo'), headers: {
      'Authorization': 'Bearer $extractedToken',
      'Content-Type': 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientInfo = Donor.fromJson(jsonDecode(response.body));
      notifyListeners();
      return _patientInfo;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<DonorOperations> fetchOperations() async {
    final response =
        await http.get(Uri.parse('$ip/api/patients/allMyOperations'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
      'Content-Type': 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientO = DonorOperations.fromJson(json.decode(response.body)[0]);
      notifyListeners();
      return _patientO;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> fetchHospitalsList() async {
    final response = await http.get(
      Uri.parse('$ip/api/patients/allHospitalsMatchingMe'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientH.clear();
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _patientH
            .add(OrganAllHospitals.fromJson(json.decode(response.body)[i]));
      }
      notifyListeners();
      return _patientH;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<DonorE1>> fetchDispensaryVisits() async {
    final response = await http.get(
      Uri.parse('$ip/api/patients/allMyDispensaryVisits'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientDis.clear();
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _patientDis.add(DonorE1.fromJson(json.decode(response.body)[i]));
      }
      notifyListeners();
      return _patientDis;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<PaitientHospitalAplied>> fetchPatientApplied() async {
    final response = await http.get(
      Uri.parse('$ip/api/patients/allHospitalsIApplied'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientApplied.clear();
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _patientApplied.add(
          PaitientHospitalAplied.fromJson(
            json.decode(response.body)[i],
          ),
        );
      }
      notifyListeners();
      return _patientApplied;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<PaitientHospitalAplied>> fetchPatientAppliedUser(
    int id,
  ) async {
    final response = await http.get(
      Uri.parse(
          '$ip/api/patients/allQueueInThisHospitalIApplied?hospitalId=$id'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientAppliedUser.clear();
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _patientAppliedUser.add(
          PaitientHospitalAplied.fromJson(
            json.decode(response.body)[i],
          ),
        );
      }
      notifyListeners();
      return _patientAppliedUser;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

class PaitientHospitalAplied {
  QueueId? queueId;
  HospitalId? hospitalId;
  Donor? patientId;

  PaitientHospitalAplied({this.queueId, this.hospitalId, this.patientId});

  PaitientHospitalAplied.fromJson(Map<String, dynamic> json) {
    queueId =
        json['queueId'] != null ? QueueId.fromJson(json['queueId']) : null;
    hospitalId = json['hospitalId'] != null
        ? HospitalId.fromJson(json['hospitalId'])
        : null;
    patientId =
        json['patientId'] != null ? Donor.fromJson(json['patientId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (queueId != null) {
      data['queueId'] = queueId!.toJson();
    }
    if (hospitalId != null) {
      data['hospitalId'] = hospitalId!.toJson();
    }
    if (patientId != null) {
      data['patientId'] = patientId!.toJson();
    }
    return data;
  }
}

class QueueId {
  int? id;
  String? name;
  OrganId? organId;
  HospitalId? hospitalId;

  QueueId({this.id, this.name, this.organId, this.hospitalId});

  QueueId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organId =
        json['organId'] != null ? OrganId.fromJson(json['organId']) : null;
    hospitalId = json['hospitalId'] != null
        ? HospitalId.fromJson(json['hospitalId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (organId != null) {
      data['organId'] = organId!.toJson();
    }
    if (hospitalId != null) {
      data['hospitalId'] = hospitalId!.toJson();
    }
    return data;
  }
}

class OrganId {
  int? id;
  String? name;

  OrganId({this.id, this.name});

  OrganId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class HospitalId {
  int? id;
  UserId? creatorId;
  String? name;
  String? address;
  OrganId? specializationOrgans;
  String? description;
  String? imageLink;
  List<Donor>? patients;

  HospitalId(
      {this.id,
      this.creatorId,
      this.name,
      this.address,
      this.specializationOrgans,
      this.description,
      this.imageLink,
      this.patients});

  HospitalId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId =
        json['creatorId'] != null ? UserId.fromJson(json['creatorId']) : null;
    name = json['name'];
    address = json['address'];
    specializationOrgans = json['specializationOrgans'] != null
        ? OrganId.fromJson(json['specializationOrgans'])
        : null;
    description = json['description'];
    imageLink = json['imageLink'];
    if (json['patients'] != null) {
      patients = <Donor>[];
      json['patients'].forEach((v) {
        patients!.add(Donor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (creatorId != null) {
      data['creatorId'] = creatorId!.toJson();
    }
    data['name'] = name;
    data['address'] = address;
    if (specializationOrgans != null) {
      data['specializationOrgans'] = specializationOrgans!.toJson();
    }
    data['description'] = description;
    data['imageLink'] = imageLink;
    if (patients != null) {
      data['patients'] = patients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
