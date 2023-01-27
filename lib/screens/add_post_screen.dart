import 'package:fb_type_app/controllers/add_post_screen_controller.dart';
import 'package:fb_type_app/db/firestore_db.dart';
import 'package:fb_type_app/db/prefs.dart';
import 'package:fb_type_app/garbage/u__ser_profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostScreen extends StatelessWidget {
  //String userProfileImageURL;
  //String? username;
  //final UserProfileScreenController c = Get.find();
   const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostScreenController>(
        init: AddPostScreenController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              leading: IconButton(onPressed: () {
                Navigator.of(context).pop();
              },
                  icon: Icon(Icons.arrow_back)),
              title: Text("Create Post"),
            ),
            body: Form(
              key: _.postvalate,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
                      child: TextFormField(
                        controller: _.postTitlecontroller,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                        ),
                      ),
                    ),
                    GetBuilder<AddPostScreenController>(
                        id: _.imagepickerKey,
                        builder: (logic) {
                      return logic.imageSelect!=null?Container(
                        height: 400,
                        width: Get.width,
                        child: Image.file(logic.imageSelect!,fit: BoxFit.cover,),
                      ):Container(
                        height: 400,
                        width: Get.width,
                        color: Colors.grey,
                        child: TextButton(onPressed: (){
                          //username=Prefs.getuserName();
                          print(Prefs.getuserName());
                          print(Prefs.getUidUser());
                          _.postImagepicker();
                        }, child: Text("Add Image",style: TextStyle(color: Colors.white),)),
                      );
                    }),
                    const SizedBox(height: 15,),
                    // Container(
                    //   width: Get.width/2,
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     color: Colors.blueAccent,
                    //     borderRadius: BorderRadius.circular(30)
                    //   ),
                    //   child: TextButton(onPressed: (){
                    //     //username=Prefs.getuserName();
                    //     print(Prefs.getuserName());
                    //     print(Prefs.getUidUser());
                    //     _.postImagepicker();
                    //   }, child: Text("Add Image",style: TextStyle(color: Colors.white),)),
                    // ),
                    const SizedBox(height: 15,),
                    Container(
                      width: Get.width/1.4,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: TextButton(onPressed: ()async{
                        if(_.postvalate.currentState!.validate()){
                          if(_.imageSelect!=null){
                            await _.uploadPostimage();
                            FirestoreDb.addPost(
                                _.postTitlecontroller.text,
                                _.uRLselectedimg,);
                            Navigator.of(context).pop();
                          }
                        }
                      }, child: Text("Add Post",style: TextStyle(color: Colors.white),)),
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
