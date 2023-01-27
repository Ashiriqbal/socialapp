import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late final String id;
  late final String postText;
  late final String uid;
  late final String name;
  late final String userProfileImageURL;
  late final String userPostImageURL;
  late final String dateTime;
  late final int likesCount;
  late final int commentsCount;
  // default constructor
  PostModel({
    required this.uid,
    required this.id,
    required this.name,
    required this.postText,
    required this.userProfileImageURL,
    required this.userPostImageURL,
    required this.dateTime,
    required this.likesCount,
    required this.commentsCount,

  });

  // for post creation
  PostModel.withoutId({
    required this.uid,
    required this.name,
    required this.postText,
    required this.userProfileImageURL,
    required this.userPostImageURL,
    required this.dateTime,

  });
  // when we read data from firebase this will be used for converting DocumentSnapshot to model object
  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    Map<String,dynamic> data =documentSnapshot.data() as Map<String,dynamic>;
    id=documentSnapshot.id??"";
    uid=data['uid']??"";
    name=data['name']??"";
    postText=data["postText"]??"";
    userPostImageURL=data["userPostImageURL"]??"";
    userProfileImageURL=data["userProfileImageURL"]??"";
    likesCount=data["likesCount"]??0;
    commentsCount=data["commentsCount"]??0;
    //dateTime=data["dateTime"]??DateTime.now().toString()??"";
  }

  // this will be used to convert PostModel.withoutId to Map<String,dynamic>
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['postText'] = postText;
    data['name']=name;
    data['userPostImageURL'] = userPostImageURL;
    data['userProfileImageURL'] = userProfileImageURL;
    data['dateTime'] = dateTime;
    return data;
  }

}