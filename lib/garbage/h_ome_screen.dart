import 'package:fb_type_app/db/firestore_db.dart';
import 'package:fb_type_app/models/post_model.dart';
import 'package:fb_type_app/garbage/u__ser_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'a__dd_post_screen.dart';
class GGHomeScreen extends StatefulWidget {
  const GGHomeScreen({Key? key}) : super(key: key);

  @override
  State<GGHomeScreen> createState() => _GGHomeScreenState();
}

class _GGHomeScreenState extends State<GGHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey
                ),
              ),

            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GGUserProfileScreen()));
          }, child: Text("My Profile",style: TextStyle(color: Colors.white),))
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
                        builder: (context) => GGUserProfileScreen()));
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            FutureBuilder(
              future: FirestoreDb.postReference.get(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.separated(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        PostModel postDetails=PostModel.fromDocumentSnapshot(documentSnapshot: snapshot.data!.docs[index]);
                        return Container(
                          width: Get.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                              child: Image.network(postDetails.userPostImageURL),
                                            ),
                                            const SizedBox(width: 8,),
                                            Column(
                                              children: [
                                                Text("Ashir Iqbal"),
                                                Text(postDetails.dateTime)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      IconButton(onPressed: (){}, icon: Icon(Icons.share))
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                Text(postDetails.postText,maxLines: 2,),
                                ],
                              ),
                              Container(
                                height: 200,
                                width: Get.width,
                                child:Image.network(postDetails.userProfileImageURL,fit: BoxFit.cover,),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("3 Likes",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade700),),
                                    Text("0 comments",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade700),)
                                  ],
                                ),
                              ),
                              Divider(thickness: 3,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up_alt_outlined)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.mode_comment_outlined)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
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
      )
    );
  }
}
