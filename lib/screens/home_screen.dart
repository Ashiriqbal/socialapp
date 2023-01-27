import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_type_app/db/firestore_db.dart';
import 'package:fb_type_app/db/prefs.dart';
import 'package:fb_type_app/models/post_model.dart';
import 'package:fb_type_app/models/user_model_meta.dart';
import 'package:fb_type_app/models/user_model_new.dart';
import 'package:fb_type_app/screens/add_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_comment_screen.dart';
import 'user_profile_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentuser=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirestoreDb.userReference.doc(
                        FirebaseAuth.instance.currentUser!.uid).get(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      UserModelNew userDetails = UserModelNew.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          Map<String, dynamic> data = snapshot.data!
                              .data() as Map<String, dynamic>;
                          UserModelMeta userDetails = UserModelMeta.fromJson(
                              data);

                          Prefs.setUidUser(currentuser!.uid);
                          print(currentuser!.uid);
                          Prefs.setUserimage(userDetails.metadata.urlprofileimage);
                          Prefs.setUsername(userDetails.firstName);
                          return Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: InkWell(
                                  onTap: (){
                                    Get.to(UserProfileScreen());
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      userDetails.metadata.urlprofileimage,
                                      fit: BoxFit.cover,),
                                  ),
                                ),),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextButton(
                                      child: const Text(
                                        "What's on your minds?",
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 20,),
                                        textAlign: TextAlign.left,
                                      ),
                                      onPressed: () {
                                        Get.to(AddPostScreen());
                                      }),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              IconButton(onPressed: () {},
                                icon: Icon(Icons.camera_alt, size: 35),)
                              //IconButton(onPressed: (){}, icon:const  ImageIcon(AssetImage('assets/images/galleryone.png'),size: 30,),)
                            ],
                          );
                        }
                      }
                      return Center();
                    },),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   height: 50,
                //   width: MediaQuery
                //       .of(context)
                //       .size
                //       .width - 40,
                //   decoration: BoxDecoration(
                //       border: Border.all(width: 1),
                //       borderRadius: BorderRadius.circular(25),
                //       ),
                //   child: TextButton(
                //       child: const Text(
                //         "What's on your minds?",
                //         style: TextStyle(
                //             color: Colors.black26,
                //             fontSize: 20,),textAlign: TextAlign.left,
                //       ),
                //       onPressed: () {
                //         Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => UserProfileScreen()));
                //       }),
                // ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: FirestoreDb.postReference.get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            PostModel postDetails = PostModel.fromDocumentSnapshot(documentSnapshot: snapshot.data!.docs[index]);
                            return Container(
                              width: Get.width,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blueAccent
                                                  ),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Get.to(UserProfileScreen());
                                                    },
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(60),
                                                        child: Image.network(
                                                          postDetails
                                                              .userProfileImageURL,
                                                          fit: BoxFit.cover,)),
                                                  ),
                                                ),
                                                const SizedBox(width: 8,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(postDetails.name,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 18),),
                                                    const SizedBox(height: 10,),
                                                    Text("20 mint ago")
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          IconButton(onPressed: () {},
                                              icon: Icon(Icons.share))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(thickness: 1,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 0, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(postDetails.postText, maxLines: 2,
                                            style: TextStyle(fontSize: 18),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){},
                                    child: Container(
                                      height: 200,
                                      width: Get.width,
                                      child: Image.network(
                                        postDetails.userPostImageURL,
                                        fit: BoxFit.cover,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 8, 12, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text("3 Likes", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700),),
                                        Text("0 comments", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700),)
                                      ],
                                    ),
                                  ),
                                  Divider(thickness: 3,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        IconButton(onPressed: () {},
                                            icon: Icon(
                                                Icons.thumb_up_alt_outlined)),
                                        IconButton(onPressed: () {
                                          Get.to(AddCommentScreen());
                                        },
                                            icon: Icon(
                                                Icons.mode_comment_outlined)),
                                        IconButton(onPressed: () {},
                                            icon: Icon(
                                                Icons.arrow_forward_rounded)),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 34,
                              color: Colors.grey,
                            );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  },

                ),
              ],
            ),
          ),

    );
  }
}
