import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelNew {
  UserModelNew({
    required this.id,
    required this.name,
    required this.email,
    required this.uid,
    required this.dob,
    required this.gender,
    required this.education,
    required this.userProfileImageURL,
    required this.coverImageUrl,
    required this.dateCreate,
    required this.dateUpdate,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
    required this.address,
  });

  late final String id;
  late final String name;
  late final String email;
  late final String uid;
  late final String dob;
  late final String gender;
  late final String education;
  late final String userProfileImageURL;
  late final String coverImageUrl;
  late final String dateCreate;
  late final String dateUpdate;
  late final String phoneNumber;
  late final String lat;
  late final String lng;
  late final String address;

  UserModelNew.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    uid = json['uid'] ?? "";
    dob = json['dob'] ?? "";
    gender = json['gender'] ?? "";
    education = json['education'] ?? "";
    userProfileImageURL = json['userProfileImageURL'] ?? "";
    coverImageUrl = json['coverImageUrl'] ?? "";
    //dateCreate = json['date_create'] ?? "";
    dateUpdate = json['date_update'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    lat = json['lat'] ?? "";
    lng = json['lng'] ?? "";
    address = json['address'] ?? "";
  }
  UserModelNew.fromDocumentsnapshot({required DocumentSnapshot snapshot}) {
    Map<String,dynamic> data =snapshot.data() as Map<String,dynamic>;
    id = snapshot.id;
    name = data['name'] ?? "";
    email = data['email'] ?? "";
    uid = data['uid'] ?? "";
    dob = data['dob'] ?? "";
    gender = data['gender'] ?? "";
    education = data['education'] ?? "";
    userProfileImageURL = data['userProfileImageURL'] ?? "";
    coverImageUrl = data['coverImageUrl'] ?? "";
    //dateCreate = data['date_create'] ?? "";
    //dateUpdate = data['date_update'] ?? "";
    phoneNumber = data['phoneNumber'] ?? "";
    lat = data['lat'] ?? "";
    lng = data['lng'] ?? "";
    address = data['address'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['uid'] = uid;
    data['dob'] = dob;
    data['gender'] = gender;
    data['education'] = education;
    data['userProfileImageURL'] = userProfileImageURL;
    data['coverImageUrl'] = coverImageUrl;
    data['date_create'] = dateCreate;
    data['date_update'] = dateUpdate;
    data['phoneNumber'] = phoneNumber;
    data['lat'] = lat;
    data['lng'] = lng;
    data['address'] = address;
    return data;
  }
}