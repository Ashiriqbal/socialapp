import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreenController extends GetxController{

  File? imageSelect;
  String uRLselectedimg='';
  String imagepickerKey='';


  TextEditingController postTitlecontroller=TextEditingController();
  GlobalKey<FormState> postvalate=GlobalKey();

  Future postImagepicker()async{
    ImagePicker _picker=ImagePicker();
    XFile? imagexfile=await _picker.pickImage(source: ImageSource.gallery);

    if(imagexfile!=null){
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagexfile.path,
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

      imageSelect =File(croppedFile!.path);
      update([imagepickerKey]);

    }
  }
  Future uploadPostimage()async{
    try {
      String filename = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      firebase_storage.Reference stroageRef = firebase_storage.FirebaseStorage.instance.ref();
      firebase_storage.Reference folderpath = stroageRef.child("postImage").child(filename);
      await folderpath.putFile(imageSelect!);
      uRLselectedimg=await folderpath.getDownloadURL();
      update();
      return true;

    }catch(e){

      print("Error in post $e");
    }
  }



}