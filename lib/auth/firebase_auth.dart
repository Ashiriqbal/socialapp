import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_type_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
//import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';

import '../db/firestore_db.dart';


class FireAuth{
  static  SignOut()async{
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }
  //User? currentUser=FirebaseAuth.instance.currentUser;
  static Future signupUser({
    required String education,
    required String urlprofileimage,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String company,
    required String city

  })async{
    bool status =false;
    try{
      final credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(

          email: email,
          password: password,
      );

      User? currentUser=credential.user;
      if(currentUser!=null){
        print("current user not null");
        Map<String,dynamic> userProfileData={
          "name":name,
          "email":email,
          "uid":currentUser.uid,
          "urlprofileimage":urlprofileimage,
          "phoneNumber": phoneNumber,
          "city":city,
          "education":education,
          "company":company,
          "dateCreate":DateTime.now().toString(),
        };
        await FirebaseChatCore.instance.createUserInFirestore(types.User(
          id: credential.user!.uid,
          firstName: name,
          imageUrl: urlprofileimage,
          metadata: userProfileData,
        ));

        // DocumentReference currentUserReference=FirestoreDb.userReference.doc(currentUser.uid);
        // Map<String,dynamic> userData={
        //   "education":education,
        //   "userProfileImageURL":urlprofileimage,
        //   "name": name,
        //   "email": email,
        //   "company":company,
        //   "city":city,
        //   "phoneNumber": phoneNumber,
        //   "userId": currentUser.uid,
        //   "dateCreate":DateTime.now().toString(),
        // };
        //
        // await currentUserReference.set(userData);
        status=true;
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return status;

  }


  static Future signInUser({required String email,required String password})async{
    bool status=false;
    print("Sign function run");
    String? token = await FirebaseMessaging.instance.getToken();
    try{
      final credential=await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Sign auth run");
      status=true;
      DocumentReference userRef=FirebaseFirestore.instance.collection("users").doc(credential.user?.uid??"");

      await userRef.update({"firebaseToken":token});

    }on FirebaseAuthException catch(e){

      print("something Wrong");
      status =false;
    }
    return status;
  }






}








// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class Auth{
//
//   CollectionReference userReference=FirebaseFirestore.instance.collection("user");
//   Future signupUser({required String email,required String password,required String fullName,required String phoneNumber})async{
//
//     bool status =false;
//     try {
//       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       User? currentUser=credential.user;
//       if(currentUser!=null){
//         DocumentReference currentUserReference=userReference.doc(currentUser.uid);
//         Map<String,dynamic>
//       }
//
//       // if(currentUser!=null){
//       //   currentUser.updateDisplayName(fullName);
//       //   currentUser.updatePhoneNumber(p)
//       // }
//
//       status=true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//     return status;
//   }
// }