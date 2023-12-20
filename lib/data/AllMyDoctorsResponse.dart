import 'dart:convert';
/// id : 1
/// fullName : "doctor"
/// email : "doctor@mail"
/// specialization : "neurologist"
/// hospitalId : {"id":2,"creatorId":{"id":6,"email":"aziko@mail.ru","password":"aziko","role":"HOSPITAL","fullName":"Aziko","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}},"name":"Azikos Hospital","address":"Registan 5","specializationOrgans":{"id":1,"name":"Lungs"},"description":"Azikos Hospital","imageLink":"Azikos Hospital_avatar.png","patients":[{"id":8,"userId":{"id":30,"email":"TESTPATIENT@mail.ru","password":"TESTPATIENT","role":"APPROVED_PATIENT","fullName":"PATIETN","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}},"phoneNumber":null,"address":null,"birthday":null,"city":null,"district":null,"passportNumber":null,"pinfl":null,"isApproved":true,"bloodType":null,"rhFactor":null,"organReceives":{"id":1,"name":"Lungs"},"urgencyRate":null,"diagnosis":null,"comments":null},{"id":1,"userId":{"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null,"regionId":null},"phoneNumber":"998946805777","address":"Registan 5","birthday":"2023-01-01","city":"Tashkent","district":"Yunusabad","passportNumber":"AC2679449","pinfl":"1991919191","isApproved":true,"bloodType":"3 minus","rhFactor":"Minus","organReceives":{"id":1,"name":"Lungs"},"urgencyRate":5,"diagnosis":"Diagnosis cancer","comments":"bla bla bla,bla bla bla"}]}

class AllDoctorsResponse {
  AllDoctorsResponse({
      this.id, 
      this.fullName, 
      this.email, 
      this.specialization, 
      this.hospitalId,});

  AllDoctorsResponse.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    specialization = json['specialization'];
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
  }
  num? id;
  String? fullName;
  String? email;
  String? specialization;
  HospitalId? hospitalId;
AllDoctorsResponse copyWith({  num? id,
  String? fullName,
  String? email,
  String? specialization,
  HospitalId? hospitalId,
}) => AllDoctorsResponse(  id: id ?? this.id,
  fullName: fullName ?? this.fullName,
  email: email ?? this.email,
  specialization: specialization ?? this.specialization,
  hospitalId: hospitalId ?? this.hospitalId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['specialization'] = specialization;
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    return map;
  }

}

/// id : 2
/// creatorId : {"id":6,"email":"aziko@mail.ru","password":"aziko","role":"HOSPITAL","fullName":"Aziko","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}}
/// name : "Azikos Hospital"
/// address : "Registan 5"
/// specializationOrgans : {"id":1,"name":"Lungs"}
/// description : "Azikos Hospital"
/// imageLink : "Azikos Hospital_avatar.png"
/// patients : [{"id":8,"userId":{"id":30,"email":"TESTPATIENT@mail.ru","password":"TESTPATIENT","role":"APPROVED_PATIENT","fullName":"PATIETN","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}},"phoneNumber":null,"address":null,"birthday":null,"city":null,"district":null,"passportNumber":null,"pinfl":null,"isApproved":true,"bloodType":null,"rhFactor":null,"organReceives":{"id":1,"name":"Lungs"},"urgencyRate":null,"diagnosis":null,"comments":null},{"id":1,"userId":{"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null,"regionId":null},"phoneNumber":"998946805777","address":"Registan 5","birthday":"2023-01-01","city":"Tashkent","district":"Yunusabad","passportNumber":"AC2679449","pinfl":"1991919191","isApproved":true,"bloodType":"3 minus","rhFactor":"Minus","organReceives":{"id":1,"name":"Lungs"},"urgencyRate":5,"diagnosis":"Diagnosis cancer","comments":"bla bla bla,bla bla bla"}]

HospitalId hospitalIdFromJson(String str) => HospitalId.fromJson(json.decode(str));
String hospitalIdToJson(HospitalId data) => json.encode(data.toJson());
class HospitalId {
  HospitalId({
      this.id, 
      this.creatorId, 
      this.name, 
      this.address, 
      this.specializationOrgans, 
      this.description, 
      this.imageLink, 
      this.patients,});

  HospitalId.fromJson(dynamic json) {
    id = json['id'];
    creatorId = json['creatorId'] != null ? CreatorId.fromJson(json['creatorId']) : null;
    name = json['name'];
    address = json['address'];
    specializationOrgans = json['specializationOrgans'] != null ? SpecializationOrgans.fromJson(json['specializationOrgans']) : null;
    description = json['description'];
    imageLink = json['imageLink'];
    if (json['patients'] != null) {
      patients = [];
      json['patients'].forEach((v) {
        patients?.add(Patients.fromJson(v));
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
  List<Patients>? patients;
HospitalId copyWith({  num? id,
  CreatorId? creatorId,
  String? name,
  String? address,
  SpecializationOrgans? specializationOrgans,
  String? description,
  String? imageLink,
  List<Patients>? patients,
}) => HospitalId(  id: id ?? this.id,
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

/// id : 8
/// userId : {"id":30,"email":"TESTPATIENT@mail.ru","password":"TESTPATIENT","role":"APPROVED_PATIENT","fullName":"PATIETN","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}}
/// phoneNumber : null
/// address : null
/// birthday : null
/// city : null
/// district : null
/// passportNumber : null
/// pinfl : null
/// isApproved : true
/// bloodType : null
/// rhFactor : null
/// organReceives : {"id":1,"name":"Lungs"}
/// urgencyRate : null
/// diagnosis : null
/// comments : null

Patients patientsFromJson(String str) => Patients.fromJson(json.decode(str));
String patientsToJson(Patients data) => json.encode(data.toJson());
class Patients {
  Patients({
      this.id, 
      this.userId, 
      this.phoneNumber, 
      this.address, 
      this.birthday, 
      this.city, 
      this.district, 
      this.passportNumber, 
      this.pinfl, 
      this.isApproved, 
      this.bloodType, 
      this.rhFactor, 
      this.organReceives, 
      this.urgencyRate, 
      this.diagnosis, 
      this.comments,});

  Patients.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    birthday = json['birthday'];
    city = json['city'];
    district = json['district'];
    passportNumber = json['passportNumber'];
    pinfl = json['pinfl'];
    isApproved = json['isApproved'];
    bloodType = json['bloodType'];
    rhFactor = json['rhFactor'];
    organReceives = json['organReceives'] != null ? OrganReceives.fromJson(json['organReceives']) : null;
    urgencyRate = json['urgencyRate'];
    diagnosis = json['diagnosis'];
    comments = json['comments'];
  }
  num? id;
  UserId? userId;
  dynamic phoneNumber;
  dynamic address;
  dynamic birthday;
  dynamic city;
  dynamic district;
  dynamic passportNumber;
  dynamic pinfl;
  bool? isApproved;
  dynamic bloodType;
  dynamic rhFactor;
  OrganReceives? organReceives;
  dynamic urgencyRate;
  dynamic diagnosis;
  dynamic comments;
Patients copyWith({  num? id,
  UserId? userId,
  dynamic phoneNumber,
  dynamic address,
  dynamic birthday,
  dynamic city,
  dynamic district,
  dynamic passportNumber,
  dynamic pinfl,
  bool? isApproved,
  dynamic bloodType,
  dynamic rhFactor,
  OrganReceives? organReceives,
  dynamic urgencyRate,
  dynamic diagnosis,
  dynamic comments,
}) => Patients(  id: id ?? this.id,
  userId: userId ?? this.userId,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  address: address ?? this.address,
  birthday: birthday ?? this.birthday,
  city: city ?? this.city,
  district: district ?? this.district,
  passportNumber: passportNumber ?? this.passportNumber,
  pinfl: pinfl ?? this.pinfl,
  isApproved: isApproved ?? this.isApproved,
  bloodType: bloodType ?? this.bloodType,
  rhFactor: rhFactor ?? this.rhFactor,
  organReceives: organReceives ?? this.organReceives,
  urgencyRate: urgencyRate ?? this.urgencyRate,
  diagnosis: diagnosis ?? this.diagnosis,
  comments: comments ?? this.comments,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (userId != null) {
      map['userId'] = userId?.toJson();
    }
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['birthday'] = birthday;
    map['city'] = city;
    map['district'] = district;
    map['passportNumber'] = passportNumber;
    map['pinfl'] = pinfl;
    map['isApproved'] = isApproved;
    map['bloodType'] = bloodType;
    map['rhFactor'] = rhFactor;
    if (organReceives != null) {
      map['organReceives'] = organReceives?.toJson();
    }
    map['urgencyRate'] = urgencyRate;
    map['diagnosis'] = diagnosis;
    map['comments'] = comments;
    return map;
  }

}

/// id : 1
/// name : "Lungs"

OrganReceives organReceivesFromJson(String str) => OrganReceives.fromJson(json.decode(str));
String organReceivesToJson(OrganReceives data) => json.encode(data.toJson());
class OrganReceives {
  OrganReceives({
      this.id, 
      this.name,});

  OrganReceives.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
OrganReceives copyWith({  num? id,
  String? name,
}) => OrganReceives(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

/// id : 30
/// email : "TESTPATIENT@mail.ru"
/// password : "TESTPATIENT"
/// role : "APPROVED_PATIENT"
/// fullName : "PATIETN"
/// imageLink : null
/// regionId : {"id":1,"name":"Tashkent"}

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));
String userIdToJson(UserId data) => json.encode(data.toJson());
class UserId {
  UserId({
      this.id, 
      this.email, 
      this.password, 
      this.role, 
      this.fullName, 
      this.imageLink, 
      this.regionId,});

  UserId.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    fullName = json['fullName'];
    imageLink = json['imageLink'];
    regionId = json['regionId'] != null ? RegionId.fromJson(json['regionId']) : null;
  }
  num? id;
  String? email;
  String? password;
  String? role;
  String? fullName;
  dynamic imageLink;
  RegionId? regionId;
UserId copyWith({  num? id,
  String? email,
  String? password,
  String? role,
  String? fullName,
  dynamic imageLink,
  RegionId? regionId,
}) => UserId(  id: id ?? this.id,
  email: email ?? this.email,
  password: password ?? this.password,
  role: role ?? this.role,
  fullName: fullName ?? this.fullName,
  imageLink: imageLink ?? this.imageLink,
  regionId: regionId ?? this.regionId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['fullName'] = fullName;
    map['imageLink'] = imageLink;
    if (regionId != null) {
      map['regionId'] = regionId?.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "Tashkent"

RegionId regionIdFromJson(String str) => RegionId.fromJson(json.decode(str));
String regionIdToJson(RegionId data) => json.encode(data.toJson());
class RegionId {
  RegionId({
      this.id, 
      this.name,});

  RegionId.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
RegionId copyWith({  num? id,
  String? name,
}) => RegionId(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

/// id : 1
/// name : "Lungs"

SpecializationOrgans specializationOrgansFromJson(String str) => SpecializationOrgans.fromJson(json.decode(str));
String specializationOrgansToJson(SpecializationOrgans data) => json.encode(data.toJson());
class SpecializationOrgans {
  SpecializationOrgans({
      this.id, 
      this.name,});

  SpecializationOrgans.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
SpecializationOrgans copyWith({  num? id,
  String? name,
}) => SpecializationOrgans(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

/// id : 6
/// email : "aziko@mail.ru"
/// password : "aziko"
/// role : "HOSPITAL"
/// fullName : "Aziko"
/// imageLink : null
/// regionId : {"id":1,"name":"Tashkent"}

CreatorId creatorIdFromJson(String str) => CreatorId.fromJson(json.decode(str));
String creatorIdToJson(CreatorId data) => json.encode(data.toJson());
class CreatorId {
  CreatorId({
      this.id, 
      this.email, 
      this.password, 
      this.role, 
      this.fullName, 
      this.imageLink, 
      this.regionId,});

  CreatorId.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    fullName = json['fullName'];
    imageLink = json['imageLink'];
    regionId = json['regionId'] != null ? RegionId.fromJson(json['regionId']) : null;
  }
  num? id;
  String? email;
  String? password;
  String? role;
  String? fullName;
  dynamic imageLink;
  RegionId? regionId;
CreatorId copyWith({  num? id,
  String? email,
  String? password,
  String? role,
  String? fullName,
  dynamic imageLink,
  RegionId? regionId,
}) => CreatorId(  id: id ?? this.id,
  email: email ?? this.email,
  password: password ?? this.password,
  role: role ?? this.role,
  fullName: fullName ?? this.fullName,
  imageLink: imageLink ?? this.imageLink,
  regionId: regionId ?? this.regionId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['fullName'] = fullName;
    map['imageLink'] = imageLink;
    if (regionId != null) {
      map['regionId'] = regionId?.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "Tashkent"
