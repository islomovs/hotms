import 'dart:convert';

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
  String? passportNumber;
  String? pinfl;
  bool? isApproved;
  String? bloodType;
  String? rhFactor;
  bool? isSmoker;
  bool? isDrinker;
  num? donationPrice;
  String? comments;

  Donor(
      {this.id,
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
      this.comments});

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
    passportNumber = json['passportNumber'];
    pinfl = json['pinfl'];
    isApproved = json['isApproved'];
    bloodType = json['bloodType'];
    rhFactor = json['rhFactor'];
    isSmoker = json['isSmoker'];
    isDrinker = json['isDrinker'];
    donationPrice = json['donationPrice'];
    comments = json['comments'];
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
    data['passportNumber'] = passportNumber;
    data['pinfl'] = pinfl;
    data['isApproved'] = isApproved;
    data['bloodType'] = bloodType;
    data['rhFactor'] = rhFactor;
    data['isSmoker'] = isSmoker;
    data['isDrinker'] = isDrinker;
    data['donationPrice'] = donationPrice;
    data['comments'] = comments;
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

class Donors with ChangeNotifier {
  final List<Donor> _donors = [];
  late Donor _donorOrganInfo = Donor();

  Donor get donorOrganInfo => _donorOrganInfo;

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
