import 'dart:convert';
/// hospitalId : {"id":2,"creatorId":{"id":6,"email":"aziko@mail.ru","password":"aziko","role":"HOSPITAL","fullName":"Aziko","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}},"name":"Azikos Hospital","address":"Registan 5","specializationOrgans":{"id":1,"name":"Lungs"},"description":"Azikos Hospital","imageLink":"Azikos Hospital_avatar.png","patients":[{"id":8,"userId":{"id":30,"email":"TESTPATIENT@mail.ru","password":"TESTPATIENT","role":"APPROVED_PATIENT","fullName":"PATIETN","imageLink":null,"regionId":{"id":1,"name":"Tashkent"}},"phoneNumber":null,"address":null,"birthday":null,"city":null,"district":null,"passportNumber":null,"pinfl":null,"isApproved":true,"bloodType":null,"rhFactor":null,"organReceives":{"id":1,"name":"Lungs"},"urgencyRate":null,"diagnosis":null,"comments":null},{"id":1,"userId":{"id":2,"email":"patient@mail.ru","password":"patient","role":"APPROVED_PATIENT","fullName":"Patient Patientov","imageLink":null,"regionId":null},"phoneNumber":"998946805777","address":"Registan 5","birthday":"2023-01-01","city":"Tashkent","district":"Yunusabad","passportNumber":"AC2679449","pinfl":"1991919191","isApproved":true,"bloodType":"3 minus","rhFactor":"Minus","organReceives":{"id":1,"name":"Lungs"},"urgencyRate":5,"diagnosis":"Diagnosis cancer","comments":"bla bla bla,bla bla bla"}]}
/// donorId : {"id":8,"userId":{"id":17,"email":"testdonor2@mail.ru","password":"testdonor2","role":"APPROVED_DONOR","fullName":"Test Donor 2","imageLink":null,"regionId":null},"phoneNumber":"998946805777","address":"address","birthday":"2000-12-09","city":"fwafwa","district":"2121","lastDonated":null,"organDonates":{"id":1,"name":"Lungs"},"passportNumber":"adwbf24","pinfl":"212","isApproved":true,"bloodType":"B","rhFactor":"Positive","isSmoker":null,"isDrinker":null,"donationPrice":12000.0,"comments":"fafw"}
/// organId : {"id":1,"name":"Lungs"}
/// price : 12000.0

AllDonorsResponse allDonorsResponseFromJson(String str) => AllDonorsResponse.fromJson(json.decode(str));
String allDonorsResponseToJson(AllDonorsResponse data) => json.encode(data.toJson());
class AllDonorsResponse {
  AllDonorsResponse({
      this.hospitalId, 
      this.donorId, 
      this.organId, 
      this.price,});

  AllDonorsResponse.fromJson(dynamic json) {
    hospitalId = json['hospitalId'] != null ? HospitalId.fromJson(json['hospitalId']) : null;
    donorId = json['donorId'] != null ? DonorId.fromJson(json['donorId']) : null;
    organId = json['organId'] != null ? OrganId.fromJson(json['organId']) : null;
    price = json['price'];
  }
  HospitalId? hospitalId;
  DonorId? donorId;
  OrganId? organId;
  num? price;
AllDonorsResponse copyWith({  HospitalId? hospitalId,
  DonorId? donorId,
  OrganId? organId,
  num? price,
}) => AllDonorsResponse(  hospitalId: hospitalId ?? this.hospitalId,
  donorId: donorId ?? this.donorId,
  organId: organId ?? this.organId,
  price: price ?? this.price,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hospitalId != null) {
      map['hospitalId'] = hospitalId?.toJson();
    }
    if (donorId != null) {
      map['donorId'] = donorId?.toJson();
    }
    if (organId != null) {
      map['organId'] = organId?.toJson();
    }
    map['price'] = price;
    return map;
  }

}

/// id : 1
/// name : "Lungs"

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
/// userId : {"id":17,"email":"testdonor2@mail.ru","password":"testdonor2","role":"APPROVED_DONOR","fullName":"Test Donor 2","imageLink":null,"regionId":null}
/// phoneNumber : "998946805777"
/// address : "address"
/// birthday : "2000-12-09"
/// city : "fwafwa"
/// district : "2121"
/// lastDonated : null
/// organDonates : {"id":1,"name":"Lungs"}
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
/// name : "Lungs"

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
/// regionId : null

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
    regionId = json['regionId'];
  }
  num? id;
  String? email;
  String? password;
  String? role;
  String? fullName;
  dynamic imageLink;
  dynamic regionId;
UserId copyWith({  num? id,
  String? email,
  String? password,
  String? role,
  String? fullName,
  dynamic imageLink,
  dynamic regionId,
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
    map['regionId'] = regionId;
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
