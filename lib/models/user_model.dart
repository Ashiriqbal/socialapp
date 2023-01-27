class UserModel {
  UserModel({
    required this.age,
    required this.email,
    required this.gender,
    required this.name,
    required this.phoneNum,
    required this.uid,
    required this.userProfileImageURL
  });
  late final String age;
  late final String email;
  late final String gender;
  late final String name;
  late final String phoneNum;
  late final String uid;
  late final String userProfileImageURL;

  UserModel.fromJson(Map<String, dynamic> json,){
    age = json['age']??"n/a";
    email = json['email']??"n/a";
    gender = json['gender']??"n/a";
    name = json['name']??"n/a";
    phoneNum = json['phoneNumber']??"n/a";
    uid=json['userId']??"n/a";
    userProfileImageURL=json['userProfileImageURL']??"n/a";

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['age'] = age;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['name'] = name;
    _data['phoneNum'] = phoneNum;
    return _data;
  }
}