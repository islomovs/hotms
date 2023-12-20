import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/contants.dart';

class Donor {
  int? id;
  UserId? userId;
  String? phoneNumber;
  String? address;
  String? birthday;
  String? city;
  String? district;

  //Null? lastDonated;
  OrganDonates? organDonates;
  OrganDonates? organReceives;
  String? passportNumber;
  String? pinfl;
  bool? isApproved;
  String? bloodType;
  String? rhFactor;
  bool? isSmoker;
  bool? isDrinker;
  num? donationPrice;
  num? urgencyRate;
  String? comments;

  Donor({
    this.id,
    this.userId,
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
    this.isSmoker,
    this.isDrinker,
    this.donationPrice,
    this.comments,
    this.organReceives,
    this.urgencyRate,
  });

  Donor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    birthday = json['birthday'];
    city = json['city'];
    district = json['district'];
    organDonates = json['organDonates'] != null
        ? OrganDonates.fromJson(json['organDonates'])
        : null;
    organReceives = json['organReceives'] != null
        ? OrganDonates.fromJson(json['organReceives'])
        : null;
    passportNumber = json['passportNumber'];
    pinfl = json['pinfl'];
    isApproved = json['isApproved'];
    bloodType = json['bloodType'];
    rhFactor = json['rhFactor'];
    isSmoker = json['isSmoker'];
    isDrinker = json['isDrinker'];
    donationPrice = json['donationPrice'];
    comments = json['comments'];
    urgencyRate = json['urgencyRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['birthday'] = birthday;
    data['city'] = city;
    data['district'] = district;
    if (organDonates != null) {
      data['organDonates'] = organDonates!.toJson();
    }
    if (organReceives != null) {
      data['organReceives'] = organReceives!.toJson();
    }
    data['passportNumber'] = passportNumber;
    data['pinfl'] = pinfl;
    data['isApproved'] = isApproved;
    data['bloodType'] = bloodType;
    data['rhFactor'] = rhFactor;
    data['isSmoker'] = isSmoker;
    data['isDrinker'] = isDrinker;
    data['donationPrice'] = donationPrice;
    data['comments'] = comments;
    data['urgencyRate'] = urgencyRate;

    return data;
  }
}

class UserId {
  int? id;
  String? email;
  String? password;
  String? role;
  String? fullName;
  String? imageLink;

  UserId(
      {this.id,
      this.email,
      this.password,
      this.role,
      this.fullName,
      this.imageLink});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    fullName = json['fullName'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['fullName'] = fullName;
    data['imageLink'] = imageLink;
    return data;
  }
}

class OrganDonates {
  int? id;
  String? name;

  OrganDonates({this.id, this.name});

  OrganDonates.fromJson(Map<String, dynamic> json) {
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

class DonorE1 {
  int? id;
  DispensaryId? dispensaryId;
  Donor? donorId;
  String? date;
  bool? isActive;
  bool? isProcessing;

  DonorE1({
    this.id,
    this.dispensaryId,
    this.donorId,
    this.date,
    this.isActive,
    this.isProcessing,
  });

  DonorE1.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    // dispensaryId = json['dispensaryId'] != null
    //     ? DispensaryId.fromJson(json['dispensaryId'])
    //     : null;
    // donorId = json['donorId'] != null ? Donor.fromJson(json['donorId']) : null;
    date = json?['date'];
    isActive = json?['isActive'];
    isProcessing = json?['isProcessing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (dispensaryId != null) {
      data['dispensaryId'] = dispensaryId!.toJson();
    }
    if (donorId != null) {
      data['donorId'] = donorId!.toJson();
    }
    data['date'] = date;
    data['isActive'] = isActive;
    data['isProcessing'] = isProcessing;
    return data;
  }
}

class DispensaryId {
  int? id;
  String? name;
  UserId? creatorId;

  DispensaryId({this.id, this.name, this.creatorId});

  DispensaryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    creatorId =
        json['creatorId'] != null ? UserId.fromJson(json['creatorId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (creatorId != null) {
      data['creatorId'] = creatorId!.toJson();
    }
    return data;
  }
}

class Donors with ChangeNotifier {
  late Donor _donorOrganInfo = Donor();

  Donor get donorOrganInfo => _donorOrganInfo;

  late DonorE1 _donorE1 = DonorE1();

  DonorE1 get donorE1 => _donorE1;

  late DonorOperations _donorO = DonorOperations();

  DonorOperations get donorO => _donorO;

  late List<OrganAllHospitals> _donorH = [];

  List<OrganAllHospitals> get donorH => _donorH;

  // Future<List<String>> fetchDonorsHospitalsList() async {
  //   final response = await http.get(
  //     Uri.parse('$ip/api/donors/allHospitalsMatchingMe'),
  //     headers: {
  //       'Authorization': 'Bearer $donorDefaultToken',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   debugPrint(response.body);
  //   if (response.statusCode == 200) {
  //     // If the server returns a 200 OK response, parse the JSON
  //     List<String> stringList = List<String>.from(json.decode(response.body));
  //     debugPrint(stringList.toString());
  //     return stringList;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // throw an exception.
  //     throw Exception('Failed to load data');
  //   }
  // }

  Future<Donor> fetchDonorInfo() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/myDonorInfo'),
      headers: {
        'Authorization': 'Bearer $donorDefaultToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _donorOrganInfo = Donor.fromJson(jsonDecode(response.body));
      notifyListeners();
      return _donorOrganInfo;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<DonorE1> fetchDispensaryVisitsInfo() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/allMyDispensaryVisits'),
      headers: {
        'Authorization': 'Bearer $donorDefaultToken',
        'Content-Type': 'application/json',
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _donorE1 = DonorE1.fromJson(json.decode(response.body)[0]);
      notifyListeners();
      return _donorE1;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<DonorOperations> fetchMyOperations() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/allMyOperations'),
      headers: {
        'Authorization': 'Bearer $donorDefaultToken',
        'Content-Type': 'application/json',
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      _donorO = DonorOperations.fromJson(json.decode(response.body)[0]);
      notifyListeners();
      return _donorO;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> fetchAllHospitals() async {
    final response = await http.get(
      Uri.parse('$ip/api/donors/allHospitalsMatchingMe'),
      headers: {
        'Authorization': 'Bearer $donorDefaultToken',
        'Content-Type': 'application/json',
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      _donorH.clear();
      log('kirdimi: ${json.decode(response.body).length}');
      // If the server returns a 200 OK response, parse the JSON
      for (int i = 0; i < json.decode(response.body).length; i++) {
        _donorH.add(OrganAllHospitals.fromJson(json.decode(response.body)[i]));
      }
      notifyListeners();
      return _donorH;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

class DonorOperations {
  int? id;
  HospitalId? hospitalId;
  Donor? patientId;
  Donor? donorId;
  OrganDonates? organId;
  String? doctorName;
  String? doctorSpecialization;
  String? operationTime;
  bool? isDonorAccepted;
  bool? operationIsSuccessful;

  DonorOperations(
      {this.id,
      this.hospitalId,
      this.patientId,
      this.donorId,
      this.organId,
      this.doctorName,
      this.doctorSpecialization,
      this.operationTime,
      this.isDonorAccepted,
      this.operationIsSuccessful});

  DonorOperations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospitalId'] != null
        ? HospitalId.fromJson(json['hospitalId'])
        : null;
    patientId =
        json['patientId'] != null ? Donor.fromJson(json['patientId']) : null;
    donorId = json['donorId'] != null ? Donor.fromJson(json['donorId']) : null;
    organId =
        json['organId'] != null ? OrganDonates.fromJson(json['organId']) : null;
    doctorName = json['doctorName'];
    doctorSpecialization = json['doctorSpecialization'];
    operationTime = json['operationTime'];
    isDonorAccepted = json['isDonorAccepted'];
    operationIsSuccessful = json['operationIsSuccessful'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (hospitalId != null) {
      data['hospitalId'] = hospitalId!.toJson();
    }
    if (patientId != null) {
      data['patientId'] = patientId!.toJson();
    }
    if (donorId != null) {
      data['donorId'] = donorId!.toJson();
    }
    if (organId != null) {
      data['organId'] = organId!.toJson();
    }
    data['doctorName'] = doctorName;
    data['doctorSpecialization'] = doctorSpecialization;
    data['operationTime'] = operationTime;
    data['isDonorAccepted'] = isDonorAccepted;
    data['operationIsSuccessful'] = operationIsSuccessful;
    return data;
  }
}

class HospitalId {
  int? id;
  UserId? creatorId;
  String? name;
  String? address;
  OrganDonates? specializationOrgans;
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
        ? OrganDonates.fromJson(json['specializationOrgans'])
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

class OrganAllHospitals {
  int? id;
  UserId? creatorId;
  String? name;
  String? address;
  OrganDonates? specializationOrgans;
  String? description;
  String? imageLink;
  List<Donor>? patients;

  OrganAllHospitals({
    this.id,
    this.creatorId,
    this.name,
    this.address,
    this.specializationOrgans,
    this.description,
    this.imageLink,
    this.patients,
  });

  OrganAllHospitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId =
        json['creatorId'] != null ? UserId.fromJson(json['creatorId']) : null;
    name = json['name'];
    address = json['address'];
    specializationOrgans = json['specializationOrgans'] != null
        ? OrganDonates.fromJson(json['specializationOrgans'])
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
