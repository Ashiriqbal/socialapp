import 'package:flutter/material.dart';

class AddCommentScreen extends StatelessWidget {
  const AddCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Comment Here"),
      ),
      body: Column(
        children: [
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Add Comment Here"
            ),
          )
        ],
      ),
    );
  }
}
