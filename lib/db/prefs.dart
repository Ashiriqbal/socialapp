import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static  String profileiImgUrlKey='profileiImgUrlkey';
  static String uidKey='Uiduserkey';
  static String userNameKey='userName';
  static late SharedPreferences preferences;

  static Future<SharedPreferences> initPrefs()async{
    print("init prefs fun cll");
     preferences = await SharedPreferences.getInstance();
     return preferences;
  }

  static setUserimage(String profileimgUrl){
    print("set img fun cll");
    preferences.setString(profileiImgUrlKey, profileimgUrl);
  }
  static getUserProfile(){
    print("get img fun cll");
    return preferences.get(profileiImgUrlKey);
  }
  static setUidUser( String userUid){

    print("set uid fun cll");
    preferences.setString(uidKey, userUid);
    print(userUid);
  }
  static getUidUser(){
    print("get uid fun cll");
    return preferences.get(uidKey);
  }
  static setUsername(String userName){
    print("set user name call0");
     preferences.setString(userNameKey, userName);
  }

  static getuserName(){
    print("get user name call");
    return preferences.get(userNameKey);
  }


}