import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreenController extends GetxController{

  File? userSelectedimage;
  String urlSelectedImage='';
  String imageupdateKey='';

  GlobalKey<FormState> formsignup = GlobalKey();
  TextEditingController companyController = TextEditingController();
  TextEditingController eduController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();



  getimageFromUser()async{
    ImagePicker _picker=ImagePicker();
    XFile? imageFile=await _picker.pickImage(source: ImageSource.gallery);
    if(imageFile!=null){
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
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

      userSelectedimage =File(croppedFile!.path);
      update([imageupdateKey]);

    }
  }
  Future uploadUserProfileImage()async{
    try{
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference stgReference = firebase_storage.FirebaseStorage.instance.ref();
      firebase_storage.Reference folderpath = stgReference.child("profileImage").child(filename);
      print("select path run");
      await folderpath.putFile(userSelectedimage!);
      print("put image run");
      urlSelectedImage = await folderpath.getDownloadURL();
      print("url code run");
      update();
      print("update code run");
      return true;
    }catch(e){
      print("error in uploaded$e");
    }
  }
}