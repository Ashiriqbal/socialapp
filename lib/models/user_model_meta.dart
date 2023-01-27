import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelMeta {
  UserModelMeta({
    required this.createdAt,
    required this.firstName,
    required this.imageUrl,
    required this.lastSeen,
    required this.updatedAt,
    required this.metadata,
  });
  late final Timestamp createdAt;
  late final String firstName;
  late final String imageUrl;
  late final Timestamp lastSeen;
  late final Timestamp updatedAt;
  late final Metadata metadata;

  UserModelMeta.fromJson(Map<String, dynamic> data){
    Map<String,dynamic> json=data as Map<String,dynamic>;
    createdAt = json['createdAt']??"";
    firstName = json['firstName']??"";
    imageUrl = json['imageUrl']??"";
    lastSeen = json['lastSeen']??"";
    updatedAt = json['updatedAt']??"";
    metadata = Metadata.fromJson(json['metadata']??{});
  }

  UserModelMeta.fromDocumentSnapshot(DocumentSnapshot snapshot){
    Map<String,dynamic> json=snapshot.data() as Map<String,dynamic>;
    createdAt = snapshot['createdAt']??"";
    firstName = snapshot['firstName']??"";
    imageUrl = snapshot['imageUrl']??"";
    lastSeen = snapshot['lastSeen']??"";
    updatedAt = snapshot['updatedAt']??"";
    metadata = Metadata.fromJson(snapshot['metadata']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['firstName'] = firstName;
    _data['imageUrl'] = imageUrl;
    _data['lastSeen'] = lastSeen;
    _data['updatedAt'] = updatedAt;
    _data['metadata'] = metadata.toJson();
    return _data;
  }

}






class Metadata {
  Metadata({
    required this.city,
    required this.urlprofileimage,
    required this.education,
    required this.uid,
    required this.company,
    required this.email,
    required this.name,
    //required this.dateCreate,
    required this.updatedAt,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
  });
  late final String city;
  late final String urlprofileimage;
  late final String education;
  late final String uid;
  late final String company;
  late final String email;
  late final String name;
  //late final String dateCreate;
  late final Timestamp updatedAt;
  late final String lat;
  late final String lng;
  late final String phoneNumber;

  Metadata.fromJson(Map<String, dynamic> json){
    city = json['city']??"";
    urlprofileimage = json['urlprofileimage']??"";
    education = json['education']??"";
    uid = json['uid']??"";
    company=json['company'];
    email=json['email'];
    name=json['name'];
    //dateCreate=json['dateCreate'];
    //updatedAt=json['updatedAt'];
    lat = json['lat']??"";
    lng = json['lng']??"";
    phoneNumber = json['phoneNumber']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['city'] = city;
    _data['urlprofileimage'] = urlprofileimage;
    _data['education'] = education;
    _data['uid'] = uid;
    _data['company']=company;
    _data['email']=email;
    _data['name']=name;
    //_data['dateCreate']=dateCreate;
    _data['updatedAt']=updatedAt;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['phoneNumber'] = phoneNumber;
    return _data;
  }










}