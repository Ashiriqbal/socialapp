import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_type_app/db/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';


class FirestoreDb {
  static CollectionReference userReference =
      FirebaseFirestore.instance.collection("users");
  static CollectionReference postReference =
      FirebaseFirestore.instance.collection("post");
  static CollectionReference commentReference =
      FirebaseFirestore.instance.collection("comments");

  static User? currentuser = FirebaseAuth.instance.currentUser;


  getAllPost() {
    postReference.get();
  }
  static addPost(String postText, String userPostImageURL,){
    String uid='';
    if(currentuser!=null){
       uid=currentuser!.uid;
    }

    Map<String,dynamic> data={
      "userProfileImageURL":Prefs.getUserProfile(),
      "name":Prefs.getuserName(),
      "userPostImageURL":userPostImageURL,
      "postText":postText,
      "uid":Prefs.getUidUser(),
      "dateTime":DateTime.now().toString(),
    };
    postReference.add(data);
  }

  // getUserProfile() {
  //   User? currentuser = FirebaseAuth.instance.currentUser;
  //   DocumentReference userDoc = userReference.doc();
  // }
/////post list complete
  // static Future<List<PostModel>> allPostsList()async{
  //   List<PostModel> postList=[];
  //   postReference.get().then((QuerySnapshot querySnapshot) {
  //     for (var doc in querySnapshot.docs){
  //       Map<String,dynamic> docdata=doc.data() as Map<String,dynamic>;
  //       postList.add(PostModel.fromDocumentSnapshot(documentSnapshot:  doc.data()[]));
  //     }
  //
  //   });
  //   return postList;
  // }
  // static Future<List<PostModel>> allPostList() async {
  //   List<PostModel> postListAll = [];
  //   await postReference.get().then((QuerySnapshot querySnapshot) {
  //     for (var doc in querySnapshot.docs) {
  //       Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
  //       postListAll.add(PostModel.fromJson(docData, doc.id));
  //       print("list Update");
  //     }
  //   }).catchError((error, stackTrace) {
  //     print("error");
  //   });
  //   return postListAll;
  // }

  // static addPost(String userPostImageURL,String titleTest,userprofileimage) async {
  //   String uid = '';
  //   if (currentuser != null) {
  //     uid = currentuser!.uid;
  //   }
  //   Map<String, dynamic> data = {
  //     "userPostImageURL":userPostImageURL,
  //     "title": titleTest,
  //     "profileImageUrl":userprofileimage,
  //     "dateandTime":DateTime.now(),
  //     "userId": uid
  //   };
  //   await postReference.add(data);
  // }

  static addCommentByUser(String postId, String bodyText) {
    String uid = '';
    if (currentuser != null) {
      uid = currentuser!.uid;
    }
    Map<String, dynamic> data = {
      "body": bodyText,
      "postId": postId,
      "userId": uid,
    };
    commentReference.add(data);
  }

  // static Future<List<PostModel>> allPostUserbyID() async {
  //   List<PostModel> postListById = [];
  //   await postReference
  //       .where('userId', isEqualTo: currentuser!.uid)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     for (var doc in querySnapshot.docs) {
  //       Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
  //       postListById.add(PostModel.fromJson(docData, doc.id));
  //       print("list Update");
  //     }
  //   }).catchError((error, stackTrace) {
  //     print("error");
  //   });
  //   return postListById;
  // }

  static Future<List<CommentModel>>getCommentOfUserByPostId(String postId) async{
    List<CommentModel> getPostCommentList = [];
    await commentReference
        .where('postId', isEqualTo: postId)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        getPostCommentList.add(CommentModel.fromJson(data,doc.id));
        print("Comment List Update");
      }
    }).catchError((error, stackTree) {
      print("Error: $error");
    });
    return getPostCommentList;
  }

//   static Future<List<PostModel>> allPostList()async{
//     List<PostModel> postListAll=[];
//     await FirestoreDb.postReference
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       for(var doc in querySnapshot.docs){
//         Map<String,dynamic> docData=doc.data() as Map<String,dynamic>;
//         postListAll.add(PostModel.fromJson(docData, doc.id));
//         print("list Update");
//       }
//     }).catchError((error,stackTrace){
//       print("error");
//     });
//     return postListAll;
//
//   }

}
