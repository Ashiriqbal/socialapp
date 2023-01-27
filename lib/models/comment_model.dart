import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel{
  CommentModel({
    required this.body,
    required this.name,
    required this.userProfileImageURL,
    required this.usercommentImageURL,
    required this.uid,
    required this.postId,
    required this.id,
  });
  late final String body;
  late final String name;
  late final String userProfileImageURL;
  late final String usercommentImageURL;
  late final String uid;
  late final String postId;
  late final String id;

  CommentModel.fromJson(Map<String, dynamic> json,String id){
    body = json['body']??"";
    name = json['name']??"";
    userProfileImageURL=json['userProfileImageURL']??"";
    usercommentImageURL=json['usercommentImageURL']??"";
    uid = json['uid']??"";
    postId=json['postId']??"";
    id=id??'';
  }
  CommentModel.fromDocumentSnapshot({required DocumentSnapshot snapshot}){
    id=snapshot.id;
    body = snapshot['body'];
    name = snapshot['name'];
    userProfileImageURL= snapshot['userProfileImageURL'];
    usercommentImageURL=snapshot['usercommentImageURL'];
    uid = snapshot['uid'];
    postId=snapshot['postId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['body'] = body;
    _data['name'] = name;
    _data['userProfileImageURL']=userProfileImageURL;
    _data['usercommentImageURL']=usercommentImageURL;
    _data['uid'] = uid;
    return _data;
  }
}