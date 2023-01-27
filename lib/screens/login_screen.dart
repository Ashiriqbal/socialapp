
import 'package:fb_type_app/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'fb_screen.dart';
import 'home_screen.dart';
import 'signup_user_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formsignin = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Form(
        key: _formsignin,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Some Text";
                  } else if (!validator.email(value)) {
                    return "Please enter valid Email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Some Text";
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blueAccent),
                child: TextButton(
                    child: const Text(
                      "Sign IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () async {
                      print("on presdd cll");
                      if (_formsignin.currentState!.validate()) {
                        print("Sign validate done");
                        if (await FireAuth.signInUser(

                            email: emailController.text,
                            password: passwordController.text)) {
                          print("Sign cll done");
                          // nameController.clear();
                          // emailController.clear();
                          // passwordController.clear();
                          // phoneNumberController.clear();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FbScreen()));
                          final snackBar = SnackBar(
                            content: const Text('Successfull Login'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Invalid User'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                      }
                    }),
              ),
              Row(
                children: [
                  Text("Not have account:"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: Text("Sign Up"))
                ],
              ),
            ],
          ),
        ),








        
      ),
    );
  }
}
