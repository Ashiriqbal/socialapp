import 'package:fb_type_app/garbage/a__dd_post_screen_controller.dart';
import 'package:fb_type_app/models/post_model.dart';
import 'package:fb_type_app/models/user_model.dart';
import 'package:fb_type_app/models/user_model_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db/firestore_db.dart';

class GGAddPostScreen extends StatelessWidget {
  UserModelNew userdetails;

  GGAddPostScreen({Key? key, required this.userdetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GGAddPostScreenController>(
        init: GGAddPostScreenController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Add Post"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _.formKey,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Some Text";
                            } else {
                              return null;
                            }
                          },
                          controller: _.titleController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                              hintText: "title",
                              border: OutlineInputBorder(
                              ),),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _.postImageUpdate();
                          },
                          child: GetBuilder<GGAddPostScreenController>(
                              id: _.imageUploadKey,
                              builder: (logic) {
                                logic.UploadImageToFirebase();
                                return logic.imageFile==null?Container(
                                  height: 400,
                                  width: Get.width,
                                  color: Colors.blue,
                                ): ClipRRect(
                                  clipBehavior: Clip.none,
                                  child: SizedBox(
                                      height: 400,
                                      width: Get.width,
                                      child: Image.file(logic.imageFile!)),
                                );
                              }),
                        ),
                        ElevatedButton(
                          onPressed: ()async{
                            if (_.formKey.currentState!.validate()) {

                              //  await FirestoreDb.addPost(
                              //     _.urlUploadedImage!,
                              //     _.titleController.text,
                              //     userdetails.userProfileImageURL
                              // );
                               _.UploadImageToFirebase();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Submit"),
                          //style: ElevatedButton.styleFrom(primary: Color(Colors.white70)),
                        ),
                      ],
                    );
                  },

                ),
              ),
            ),
          );
        });
  }
}
