import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';
import 'donor.dart';

class Patients with ChangeNotifier {
  late final List<OrganAllHospitals> _patientH = [];

  List<OrganAllHospitals> get patientH => _patientH;

  late final List<DonorE1> _patientDis = [];

  List<DonorE1> get patientDis => _patientDis;

  late Donor _patientInfo = Donor();

  Donor get patientInfo => _patientInfo;

  late DonorOperations _patientO = DonorOperations();

  DonorOperations get patientO => _patientO;

  Future<Donor> fetchPatientInfo() async {
    final response =
        await http.get(Uri.parse('$ip/api/patients/myInfo'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
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
    final response = await http
        .get(Uri.parse('$ip/api/patients/allHospitalsMatchingMe'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MiwiZW1haWwiOiJwYXRpZW50QG1haWwucnUiLCJyb2xlIjoiQVBQUk9WRURfUEFUSUVOVCIsInVzZXIiOnsiaWQiOjIsImVtYWlsIjoicGF0aWVudEBtYWlsLnJ1IiwicGFzc3dvcmQiOiJwYXRpZW50Iiwicm9sZSI6IkFQUFJPVkVEX1BBVElFTlQiLCJmdWxsTmFtZSI6IlBhdGllbnQgUGF0aWVudG92IiwiaW1hZ2VMaW5rIjpudWxsfSwiZXhwIjoxNzAzNTM2MjAzfQ.WhePbl22Z8g0LoCx_QO_vWrijwaG3ZbVwEJsgwC8t1riwryrEBvrgaeSvNsWP207xex_rVrshdrMSHmBZSVQsg',
      'Content-Type': 'application/json',
    });
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
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _patientDis.clear();
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _patientDis
            .add(DonorE1.fromJson(json.decode(response.body)[i]));
      }
      notifyListeners();
      return _patientDis;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
