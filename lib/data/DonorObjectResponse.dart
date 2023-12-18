import 'package:myapp/providers/dispensary.dart';

class DonorObjectResponse extends DonorOrPatient {
  DonorObjectResponse({
    this.id,
    this.dispensaryId,
    this.donorId,
    this.date,
    this.isActive,
    this.isProcessing,
  }) : super(isPatient: false, isApproved: donorId?.isApproved, date: date);

  factory DonorObjectResponse.fromJson(dynamic json) {
    return DonorObjectResponse(
        id: json['id'],
        dispensaryId: json['dispensaryId'] != null
            ? DispensaryId.fromJson(json['dispensaryId'])
            : null,
        donorId:
            json['donorId'] != null ? DonorId.fromJson(json['donorId']) : null,
        date: json['date'],
        isActive: json['isActive'],
        isProcessing: json['isProcessing']);
  }

  num? id;
  DispensaryId? dispensaryId;
  DonorId? donorId;
  String? date;
  bool? isActive;
  bool? isProcessing;

  DonorObjectResponse copyWith({
    num? id,
    DispensaryId? dispensaryId,
    DonorId? donorId,
    String? date,
    bool? isActive,
    dynamic isProcessing,
  }) =>
      DonorObjectResponse(
        id: id ?? this.id,
        dispensaryId: dispensaryId ?? this.dispensaryId,
        donorId: donorId ?? this.donorId,
        date: date ?? this.date,
        isActive: isActive ?? this.isActive,
        isProcessing: isProcessing ?? this.isProcessing,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (dispensaryId != null) {
      map['dispensaryId'] = dispensaryId?.toJson();
    }
    if (donorId != null) {
      map['donorId'] = donorId?.toJson();
    }
    map['date'] = date;
    map['isActive'] = isActive;
    map['isProcessing'] = isProcessing;
    return map;
  }
}

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
    this.comments,
  });

  DonorId.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    birthday = json['birthday'];
    city = json['city'];
    district = json['district'];
    lastDonated = json['lastDonated'];
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

  DonorId copyWith({
    num? id,
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
  }) =>
      DonorId(
        id: id ?? this.id,
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

class OrganDonates {
  OrganDonates({
    this.id,
    this.name,
  });

  OrganDonates.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num? id;
  String? name;

  OrganDonates copyWith({
    num? id,
    String? name,
  }) =>
      OrganDonates(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class UserId {
  UserId({
    this.id,
    this.email,
    this.password,
    this.role,
    this.fullName,
    this.imageLink,
  });

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

  UserId copyWith({
    num? id,
    String? email,
    String? password,
    String? role,
    String? fullName,
    dynamic imageLink,
  }) =>
      UserId(
        id: id ?? this.id,
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

class DispensaryId {
  DispensaryId({
    this.id,
    this.name,
    this.creatorId,
  });

  DispensaryId.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    creatorId = json['creatorId'] != null
        ? CreatorId.fromJson(json['creatorId'])
        : null;
  }

  num? id;
  String? name;
  CreatorId? creatorId;

  DispensaryId copyWith({
    num? id,
    String? name,
    CreatorId? creatorId,
  }) =>
      DispensaryId(
        id: id ?? this.id,
        name: name ?? this.name,
        creatorId: creatorId ?? this.creatorId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (creatorId != null) {
      map['creatorId'] = creatorId?.toJson();
    }
    return map;
  }
}

class CreatorId {
  CreatorId({
    this.id,
    this.email,
    this.password,
    this.role,
    this.fullName,
    this.imageLink,
  });

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

  CreatorId copyWith({
    num? id,
    String? email,
    String? password,
    String? role,
    String? fullName,
    dynamic imageLink,
  }) =>
      CreatorId(
        id: id ?? this.id,
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
