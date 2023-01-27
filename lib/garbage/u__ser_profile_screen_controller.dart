import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../db/firestore_db.dart';

class UserProfileScreenController extends GetxController{
  User? currentuser=FirebaseAuth.instance.currentUser;
File? imageFile;
String imageUpdateKey='keyimage';
profileImageUpdate()async{
  ImagePicker _picker=ImagePicker();
  final XFile? image=await  _picker.pickImage(source: ImageSource.camera);
  if(image!=null){
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),

      ],
    );




    imageFile =File(croppedFile!.path);
    update([imageUpdateKey]);
  }
}
Future UploadImageToFirebase()async{
  String filename=DateTime.now().millisecondsSinceEpoch.toString();
  firebase_storage.Reference storageRootreference = firebase_storage.FirebaseStorage.instance.ref();
  firebase_storage.Reference directoryReference=storageRootreference.child("profileImage").child("/$filename");
  try{
    directoryReference.putFile(imageFile!);
    String urlUploadedImage=await directoryReference.getDownloadURL();
    if(imageFile!=null){
      String uid='';
      if(currentuser!=null){
        uid =currentuser!.uid;
      }
      try{
        DocumentReference currentUserReference=FirestoreDb.userReference.doc(uid);
        await currentUserReference.update(
            {"userProfileImageURL": urlUploadedImage});



        return true;
      }catch(e){
        return false;
      }
    }





  }on Exception catch(e){};
  return false;
}






}