import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'u__ser_profile_screen_controller.dart';
import '../db/firestore_db.dart';
import '../models/user_model_new.dart';
import 'a__dd_post_screen.dart';

class GGUserProfileScreen extends StatefulWidget {
  const GGUserProfileScreen({Key? key}) : super(key: key);

  @override
  State<GGUserProfileScreen> createState() => _GGUserProfileScreenState();
}

class _GGUserProfileScreenState extends State<GGUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileScreenController>(
        init: UserProfileScreenController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text("User Profile"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<DocumentSnapshot>(
                    future: FirestoreDb.userReference
                        .doc(FirestoreDb.currentuser!.uid)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          UserModelNew details = UserModelNew.fromJson(
                              snapshot.data!.data() as Map<String, dynamic>);
                          return Container(
                            child: Column(
                              children: [
                                Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 250,
                                        decoration: BoxDecoration(
                                            color: Colors.black54),
                                      ),
                                      Positioned(
                                        bottom: -35,
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 2 - 50,
                                        child: InkWell(
                                          onTap: () async {
                                            await _.profileImageUpdate();
                                            _.UploadImageToFirebase();
                                          },
                                          child: GetBuilder<UserProfileScreenController>(
                                              id: _.imageUpdateKey,
                                              builder: (logic) {
                                                logic.UploadImageToFirebase();
                                                // User? currentuser=FirebaseAuth.instance.currentUser;
                                                // Map<String,dynamic> data=FirestoreDb.userReference.where('userId',isEqualTo: currentuser!.uid).get() as Map<String,dynamic>;
                                                // String networkimg=data['userProfileImage'];
                                                return ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(120),
                                                  child: SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.network(
                                                        details.userProfileImageURL,
                                                        fit: BoxFit.cover,)),
                                                );
                                              }),
                                        ),
                                      )
                                    ]),
                                const SizedBox(
                                  height: 40,
                                ),
                                Text("\n${details.name}", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                                Text("${details.phoneNumber}", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.redAccent)),
                                Text("${details.email}", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blueAccent)),
                                Text("${details.uid}"),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.blueAccent),
                                  child: TextButton(
                                      child: const Text(
                                        "Create Post",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => GGAddPostScreen(userdetails: details,)));
                                      }),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  FutureBuilder(
                    //future: FirestoreDb.allPostUserbyID(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            //itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              //PostModel postDetails = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      //height: 200,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width - 60,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: [
                                            // Text(
                                            //   "${postDetails.title}",
                                            //   style: TextStyle(
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 22),
                                            // ),
                                            // Text(
                                            //   "${postDetails.body}",
                                            //   style: TextStyle(
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 22),
                                            // ),
                                            // Text(
                                            //   "${postDetails.id}",
                                            //   style: TextStyle(
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 22),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
