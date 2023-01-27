import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_type_app/db/firestore_db.dart';
import 'package:fb_type_app/garbage/u__ser_profile_screen_controller.dart';
import 'package:fb_type_app/models/user_model_meta.dart';
import 'package:fb_type_app/screens/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  final UserProfileScreenController  user=Get.put(UserProfileScreenController());
   UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            FutureBuilder<DocumentSnapshot>(
              future: FirestoreDb.userReference.doc(FirestoreDb.currentuser!.uid).get(),
              //future: FirestoreDb.userReference.where("uid",isEqualTo: FirestoreDb.currentuser!.uid).get(),
              builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                if(snapshot.data!=null){
                  print("snapShot data is not null");
                  print(snapshot.data!.data() as Map<String,dynamic>);
                  //print(snapshot.data);
                  //print(snapshot);

                  // return ListView.builder(
                  //     itemCount: snapshot.data!.doc,
                  //     itemBuilder: (context,index){
                   UserModelMeta userDetails=UserModelMeta.fromJson(snapshot.data!.data() as Map<String,dynamic>);
                   //print(userDetails.metadata);
                    //UserModelMeta userDetails=UserModelMeta.fromDocumentSnapshot(snapshot.data!.data() as DocumentSnapshot);
                    return Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                           children:[ 
                             Container(
                            height: 200,
                            width: Get.width,
                            child: Image.asset("assets/images/coverpic.jpg",fit: BoxFit.cover,),
                          ),
                           Positioned(
                             bottom: -80,
                             left: Get.width/2-70,
                             child: Container(
                               height: 140,
                               width: 140,
                               // decoration: BoxDecoration(
                               //   borderRadius: BorderRadius.circular(100),
                               // ),
                               child: ClipRRect(
                                   borderRadius: BorderRadius.circular(100),
                                   child: Image.network(userDetails.metadata.urlprofileimage,fit: BoxFit.cover,)
                                 ),
                             ),
                           )
                           ]
                        ),
                        const SizedBox(height: 80,),
                        ReuseableRow(title: "Name", value: userDetails.firstName),
                        ReuseableRow(title: "Education", value: userDetails.metadata.education),
                        ReuseableRow(title: "Company", value: userDetails.metadata.company),
                        ReuseableRow(title:" Email", value: userDetails.metadata.email),
                        ReuseableRow(title: "Phone Number", value: userDetails.metadata.phoneNumber),
                        ReuseableRow(title: "Address", value: userDetails.metadata.city),
                        Container(

                          width: Get.width-40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue
                          ),
                          child: TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPostScreen()));
                          }, child: Text("Add Post",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18))),
                        ),
                      ],
                    );

                }
              }return Center(
                child: CircularProgressIndicator(),
              );
            },)
          ],
        ),
      ),
    );
  }
}



class ReuseableRow extends StatelessWidget {
  String title;
  String value;
   ReuseableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style:TextStyle(fontSize: 15),),
              Text(value,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black87),),
            ],
          ),
          Divider(thickness: 3,),
          const SizedBox(height: 1,),
        ],
      ),
    );
  }
}
