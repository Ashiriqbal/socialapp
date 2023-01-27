import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_type_app/models/user_model_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../db/firestore_db.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  getAllUser(){
    List userList=[];
    CollectionReference userRefrence=FirebaseFirestore.instance.collection("user");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: FirestoreDb.userReference.get(),
            builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  Map<String,dynamic> data=snapshot.data!.docs[index] as Map<String,dynamic>;
                  UserModelNew userDetails=UserModelNew.fromDocumentsnapshot(snapshot: data[index]);
                  return ListTile(
                    leading: Image.network(userDetails.userProfileImageURL),
                    title: Text(userDetails.name),
                    subtitle: Text(userDetails.email),
                  );
                });
          },)
        ],
      ),
    );
  }
}
