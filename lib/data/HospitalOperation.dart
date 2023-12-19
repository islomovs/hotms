import 'dart:convert';
/// id : 2
/// hospitalId : {"id":2,"creatorId":{"id":6,"email":"aziko@mail.ru","password":"aziko","role":"HOSPITAL","fullName":"Aziko","imageLink":null},"name":"Azikos Hospital","address":"Registan 5","specializationOrgans":{"id":1,"name":"lungs"},"description":"Azikos Hospital","imageLink":"Azikos Hospital_avatar.png","patients":[{"id":1,"userId":{"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null},"phoneNumber":"998946805777","address":"Registan 5","birthday":"2023-01-01","city":"Tashkent","district":"Yunusabad","passportNumber":"AC2679449","pinfl":"1991919191","isApproved":true,"bloodType":"3 minus","rhFactor":"Minus","organReceives":{"id":1,"name":"lungs"},"urgencyRate":5,"diagnosis":"Diagnosis cancer","comments":"bla bla bla,bla bla bla"}]}
/// patientId : {"id":1,"userId":{"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null},"phoneNumber":"998946805777","address":"Registan 5","birthday":"2023-01-01","city":"Tashkent","district":"Yunusabad","passportNumber":"AC2679449","pinfl":"1991919191","isApproved":true,"bloodType":"3 minus","rhFactor":"Minus","organReceives":{"id":1,"name":"lungs"},"urgencyRate":5,"diagnosis":"Diagnosis cancer","comments":"bla bla bla,bla bla bla"}
/// donorId : {"id":8,"userId":{"id":17,"email":"testdonor2@mail.ru","password":"testdonor2","role":"APPROVED_DONOR","fullName":"Test Donor 2","imageLink":null},"phoneNumber":"998946805777","address":"address","birthday":"2000-12-09","city":"fwafwa","district":"2121","lastDonated":null,"organDonates":{"id":1,"name":"lungs"},"passportNumber":"adwbf24","pinfl":"212","isApproved":true,"bloodType":"B","rhFactor":"Positive","isSmoker":null,"isDrinker":null,"donationPrice":12000.0,"comments":"fafw"}
/// organId : {"id":1,"name":"lungs"}
/// doctorName : "Doctor Who"
/// doctorSpecialization : "Surgeon"
/// operationTime : "2023-12-15 18:25"
/// isDonorAccepted : null
/// operationIsSuccessful : null

HospitalOperation hospitalOperationFromJson(String str) => HospitalOperation.fromJson(json.decode(str));
String hospitalOperationToJson(HospitalOperation data) => json.encode(data.toJson());
class HospitalOperation {
  HospitalOperation({
      this.id, 
      this.hospitalId, 
      this.patientId, 
      this.donorId, 
      this.organId, 
      this.doctorName, 
      this.doctorSpecialization, 
      this.operationTime, 
      this.isDonorAccepted, 
      this.operationIsSuccessful,});

  HospitalOperation.fromJson(dynamic json) {
    id = json['id'];
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    patientId = json['patientId'] != null ? PatientId.fromJson(json['patientId']) : null;
    donorId = json['donorId'] != null ? DonorId.fromJson(json['donorId']) : null;
    organId = json['organId'] != null ? OrganId.fromJson(json['organId']) : null;
    doctorName = json['doctorName'];
    doctorSpecialization = json['doctorSpecialization'];
    operationTime = json['operationTime'];
    isDonorAccepted = json['isDonorAccepted'];
    operationIsSuccessful = json['operationIsSuccessful'];
  }
  num? id;
  HospitalId? hospitalId;
  PatientId? patientId;
  DonorId? donorId;
  OrganId? organId;
  String? doctorName;
  String? doctorSpecialization;
  String? operationTime;
  dynamic isDonorAccepted;
  dynamic operationIsSuccessful;
HospitalOperation copyWith({  num? id,
  HospitalId? hospitalId,
  PatientId? patientId,
  DonorId? donorId,
  OrganId? organId,
  String? doctorName,
  String? doctorSpecialization,
  String? operationTime,
  dynamic isDonorAccepted,
  dynamic operationIsSuccessful,
}) => HospitalOperation(  id: id ?? this.id,
  hospitalId: hospitalId ?? this.hospitalId,
  patientId: patientId ?? this.patientId,
  donorId: donorId ?? this.donorId,
  organId: organId ?? this.organId,
  doctorName: doctorName ?? this.doctorName,
  doctorSpecialization: doctorSpecialization ?? this.doctorSpecialization,
  operationTime: operationTime ?? this.operationTime,
  isDonorAccepted: isDonorAccepted ?? this.isDonorAccepted,
  operationIsSuccessful: operationIsSuccessful ?? this.operationIsSuccessful,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    if (patientId != null) {
      map['patientId'] = patientId?.toJson();
    }
    if (donorId != null) {
      map['donorId'] = donorId?.toJson();
    }
    if (organId != null) {
      map['organId'] = organId?.toJson();
    }
    map['doctorName'] = doctorName;
    map['doctorSpecialization'] = doctorSpecialization;
    map['operationTime'] = operationTime;
    map['isDonorAccepted'] = isDonorAccepted;
    map['operationIsSuccessful'] = operationIsSuccessful;
    return map;
  }

}

/// id : 1
/// name : "lungs"

OrganId organIdFromJson(String str) => OrganId.fromJson(json.decode(str));
String organIdToJson(OrganId data) => json.encode(data.toJson());
class OrganId {
  OrganId({
      this.id, 
      this.name,});

  OrganId.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
OrganId copyWith({  num? id,
  String? name,
}) => OrganId(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

/// id : 8
/// userId : {"id":17,"email":"testdonor2@mail.ru","password":"testdonor2","role":"APPROVED_DONOR","fullName":"Test Donor 2","imageLink":null}
/// phoneNumber : "998946805777"
/// address : "address"
/// birthday : "2000-12-09"
/// city : "fwafwa"
/// district : "2121"
/// lastDonated : null
/// organDonates : {"id":1,"name":"lungs"}
/// passportNumber : "adwbf24"
/// pinfl : "212"
/// isApproved : true
/// bloodType : "B"
/// rhFactor : "Positive"
/// isSmoker : null
/// isDrinker : null
/// donationPrice : 12000.0
/// comments : "fafw"

DonorId donorIdFromJson(String str) => DonorId.fromJson(json.decode(str));
String donorIdToJson(DonorId data) => json.encode(data.toJson());
class DonorId {
  DonorId({
      this.id, 
      this.userId, 
      this.phoneNumber, 
      this.address, 
      this.birthday, 
      this.city, 
      this.district, 
      this.lastDonated, 
      this.organDonates, 
      this.passportNumber, 
      this.pinfl, 
      this.isApproved, 
      this.bloodType, 
      this.rhFactor, 
      this.isSmoker, 
      this.isDrinker, 
      this.donationPrice, 
      this.comments,});

  DonorId.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    birthday = json['birthday'];
    city = json['city'];
    district = json['district'];
    lastDonated = json['lastDonated'];
    organDonates = json['organDonates'] != null ? OrganDonates.fromJson(json['organDonates']) : null;
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
  num? id;
  UserId? userId;
  String? phoneNumber;
  String? address;
  String? birthday;
  String? city;
  String? district;
  dynamic lastDonated;
  OrganDonates? organDonates;
  String? passportNumber;
  String? pinfl;
  bool? isApproved;
  String? bloodType;
  String? rhFactor;
  dynamic isSmoker;
  dynamic isDrinker;
  num? donationPrice;
  String? comments;
DonorId copyWith({  num? id,
  UserId? userId,
  String? phoneNumber,
  String? address,
  String? birthday,
  String? city,
  String? district,
  dynamic lastDonated,
  OrganDonates? organDonates,
  String? passportNumber,
  String? pinfl,
  bool? isApproved,
  String? bloodType,
  String? rhFactor,
  dynamic isSmoker,
  dynamic isDrinker,
  num? donationPrice,
  String? comments,
}) => DonorId(  id: id ?? this.id,
  userId: userId ?? this.userId,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  address: address ?? this.address,
  birthday: birthday ?? this.birthday,
  city: city ?? this.city,
  district: district ?? this.district,
  lastDonated: lastDonated ?? this.lastDonated,
  organDonates: organDonates ?? this.organDonates,
  passportNumber: passportNumber ?? this.passportNumber,
  pinfl: pinfl ?? this.pinfl,
  isApproved: isApproved ?? this.isApproved,
  bloodType: bloodType ?? this.bloodType,
  rhFactor: rhFactor ?? this.rhFactor,
  isSmoker: isSmoker ?? this.isSmoker,
  isDrinker: isDrinker ?? this.isDrinker,
  donationPrice: donationPrice ?? this.donationPrice,
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
    map['lastDonated'] = lastDonated;
    if (organDonates != null) {
      map['organDonates'] = organDonates?.toJson();
    }
    map['passportNumber'] = passportNumber;
    map['pinfl'] = pinfl;
    map['isApproved'] = isApproved;
    map['bloodType'] = bloodType;
    map['rhFactor'] = rhFactor;
    map['isSmoker'] = isSmoker;
    map['isDrinker'] = isDrinker;
    map['donationPrice'] = donationPrice;
    map['comments'] = comments;
    return map;
  }

}

/// id : 1
/// name : "lungs"

OrganDonates organDonatesFromJson(String str) => OrganDonates.fromJson(json.decode(str));
String organDonatesToJson(OrganDonates data) => json.encode(data.toJson());
class OrganDonates {
  OrganDonates({
      this.id, 
      this.name,});

  OrganDonates.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
OrganDonates copyWith({  num? id,
  String? name,
}) => OrganDonates(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

/// id : 17
/// email : "testdonor2@mail.ru"
/// password : "testdonor2"
/// role : "APPROVED_DONOR"
/// fullName : "Test Donor 2"
/// imageLink : null

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));
String userIdToJson(UserId data) => json.encode(data.toJson());
class UserId {
  UserId({
      this.id, 
      this.email, 
      this.password, 
      this.role, 
      this.fullName, 
      this.imageLink,});

  UserId.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    fullName = json['fullName'];
    imageLink = json['imageLink'];
  }
  num? id;
  String? email;
  String? password;
  String? role;
  String? fullName;
  dynamic imageLink;
UserId copyWith({  num? id,
  String? email,
  String? password,
  String? role,
  String? fullName,
  dynamic imageLink,
}) => UserId(  id: id ?? this.id,
  email: email ?? this.email,
  password: password ?? this.password,
  role: role ?? this.role,
  fullName: fullName ?? this.fullName,
  imageLink: imageLink ?? this.imageLink,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['fullName'] = fullName;
    map['imageLink'] = imageLink;
    return map;
  }

}

/// id : 1
/// userId : {"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null}
/// phoneNumber : "998946805777"
/// address : "Registan 5"
/// birthday : "2023-01-01"
/// city : "Tashkent"
/// district : "Yunusabad"
/// passportNumber : "AC2679449"
/// pinfl : "1991919191"
/// isApproved : true
/// bloodType : "3 minus"
/// rhFactor : "Minus"
/// organReceives : {"id":1,"name":"lungs"}
/// urgencyRate : 5
/// diagnosis : "Diagnosis cancer"
/// comments : "bla bla bla,bla bla bla"

PatientId patientIdFromJson(String str) => PatientId.fromJson(json.decode(str));
String patientIdToJson(PatientId data) => json.encode(data.toJson());
class PatientId {
  PatientId({
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

  PatientId.fromJson(dynamic json) {
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
  String? phoneNumber;
  String? address;
  String? birthday;
  String? city;
  String? district;
  String? passportNumber;
  String? pinfl;
  bool? isApproved;
  String? bloodType;
  String? rhFactor;
  OrganReceives? organReceives;
  num? urgencyRate;
  String? diagnosis;
  String? comments;
PatientId copyWith({  num? id,
  UserId? userId,
  String? phoneNumber,
  String? address,
  String? birthday,
  String? city,
  String? district,
  String? passportNumber,
  String? pinfl,
  bool? isApproved,
  String? bloodType,
  String? rhFactor,
  OrganReceives? organReceives,
  num? urgencyRate,
  String? diagnosis,
  String? comments,
}) => PatientId(  id: id ?? this.id,
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
/// name : "lungs"

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

/// id : 2
/// email : "patient@mail.ru"
/// password : "patient"
/// role : "APPROVED_PATIENT"
/// fullName : "Patient Patientov"
/// imageLink : null


/// id : 2
/// creatorId : {"id":6,"email":"aziko@mail.ru","password":"aziko","role":"HOSPITAL","fullName":"Aziko","imageLink":null}
/// name : "Azikos Hospital"
/// address : "Registan 5"
/// specializationOrgans : {"id":1,"name":"lungs"}
/// description : "Azikos Hospital"
/// imageLink : "Azikos Hospital_avatar.png"
/// patients : [{"id":1,"userId":{"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null},"phoneNumber":"998946805777","address":"Registan 5","birthday":"2023-01-01","city":"Tashkent","district":"Yunusabad","passportNumber":"AC2679449","pinfl":"1991919191","isApproved":true,"bloodType":"3 minus","rhFactor":"Minus","organReceives":{"id":1,"name":"lungs"},"urgencyRate":5,"diagnosis":"Diagnosis cancer","comments":"bla bla bla,bla bla bla"}]

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

/// id : 1
/// userId : {"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null}
/// phoneNumber : "998946805777"
/// address : "Registan 5"
/// birthday : "2023-01-01"
/// city : "Tashkent"
/// district : "Yunusabad"
/// passportNumber : "AC2679449"
/// pinfl : "1991919191"
/// isApproved : true
/// bloodType : "3 minus"
/// rhFactor : "Minus"
/// organReceives : {"id":1,"name":"lungs"}
/// urgencyRate : 5
/// diagnosis : "Diagnosis cancer"
/// comments : "bla bla bla,bla bla bla"

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
  String? phoneNumber;
  String? address;
  String? birthday;
  String? city;
  String? district;
  String? passportNumber;
  String? pinfl;
  bool? isApproved;
  String? bloodType;
  String? rhFactor;
  OrganReceives? organReceives;
  num? urgencyRate;
  String? diagnosis;
  String? comments;
Patients copyWith({  num? id,
  UserId? userId,
  String? phoneNumber,
  String? address,
  String? birthday,
  String? city,
  String? district,
  String? passportNumber,
  String? pinfl,
  bool? isApproved,
  String? bloodType,
  String? rhFactor,
  OrganReceives? organReceives,
  num? urgencyRate,
  String? diagnosis,
  String? comments,
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
/// name : "lungs"


/// id : 2
/// email : "patient@mail.ru"
/// password : "patient"
/// role : "APPROVED_PATIENT"
/// fullName : "Patient Patientov"
/// imageLink : null


/// id : 1
/// name : "lungs"

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

CreatorId creatorIdFromJson(String str) => CreatorId.fromJson(json.decode(str));
String creatorIdToJson(CreatorId data) => json.encode(data.toJson());
class CreatorId {
  CreatorId({
      this.id, 
      this.email, 
      this.password, 
      this.role, 
      this.fullName, 
      this.imageLink,});

  CreatorId.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    fullName = json['fullName'];
    imageLink = json['imageLink'];
  }
  num? id;
  String? email;
  String? password;
  String? role;
  String? fullName;
  dynamic imageLink;
CreatorId copyWith({  num? id,
  String? email,
  String? password,
  String? role,
  String? fullName,
  dynamic imageLink,
}) => CreatorId(  id: id ?? this.id,
  email: email ?? this.email,
  password: password ?? this.password,
  role: role ?? this.role,
  fullName: fullName ?? this.fullName,
  imageLink: imageLink ?? this.imageLink,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['fullName'] = fullName;
    map['imageLink'] = imageLink;
    return map;
  }

}