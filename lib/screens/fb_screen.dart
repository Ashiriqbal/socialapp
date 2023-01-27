import 'package:fb_type_app/chat/audio_video_call/agora_call_screen.dart';
import 'package:fb_type_app/screens/add_post_screen.dart';
import 'package:fb_type_app/screens/chat_screen.dart';
import 'package:fb_type_app/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat/users.dart';
import 'home_screen.dart';

class FbScreen extends StatelessWidget {
  const FbScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 4,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
              leading: IconButton(onPressed: (){}, icon: const Icon(Icons.facebook,color: Colors.blue,size: 40,)),
              title:const Text("facebook",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
              bottom: const TabBar(
                labelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.blue,

                  unselectedLabelColor: Colors.blue,
                  tabs: [
                    Tab(icon: Icon(Icons.home,color: Colors.black54,size: 25,)),
                  Tab(icon: Icon(Icons.add_card_sharp,color: Colors.black54,size: 25,),),
                    Tab(icon: Icon(Icons.notifications_active_outlined,color: Colors.black54,size: 25,),),
                    Tab(icon: Icon(Icons.account_circle_outlined,color: Colors.black54,size: 25,),),
                  ]),
          actions: [
            Row(
              children: [
                IconButton(onPressed: (){Get.to(AddPostScreen());}, icon: Icon(Icons.add,color: Colors.black54,size: 30,)),
                IconButton(onPressed: (){Get.to(AgoraCallScreen());}, icon: Icon(Icons.search,color: Colors.black54,size: 30,)),
                IconButton(onPressed: (){Get.to(UsersPage());}, icon: Icon(Icons.chat,color: Colors.black54,size: 30,)),
              ],
            )
          ],
            ),

        body: TabBarView(
        children: [
          const HomeScreen(),
          const Center(child: CircularProgressIndicator(),),
          const Center(child: CircularProgressIndicator(),),
          UserProfileScreen(),
        ]),
      ),
    );
  }
}
