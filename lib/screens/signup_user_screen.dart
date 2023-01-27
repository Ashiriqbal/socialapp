import 'package:fb_type_app/controllers/signup_screen_controller.dart';
import 'package:fb_type_app/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regexed_validator/regexed_validator.dart';
import '../auth/firebase_auth.dart';
import 'fb_screen.dart';
import 'home_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupScreenController>
      (init: SignupScreenController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _.formsignup,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            GetBuilder<SignupScreenController>(id: _.imageupdateKey,builder: (logic) {
                              return Container(
                                child: logic.userSelectedimage!= null ? Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      logic.userSelectedimage!, fit: BoxFit.cover,),
                                  ),
                                ) : Container(
                                  height: 120,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: TextButton(onPressed: () {

                                   _.getimageFromUser();

                                   }, child: Text("Add Image")),
                                ),
                              );
                            },),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Some Text";
                          } else if (!validator.name(value)) {
                            return "Please enter valid name";
                          } else {
                            return null;
                          }
                        },
                        controller: _.nameController,
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Some Text";
                          } else {
                            return null;
                          }
                        },
                        controller: _.companyController,
                        decoration: InputDecoration(
                          hintText: "Company Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Education";
                          } else {
                            return null;
                          }
                        },
                        controller: _.eduController,
                        decoration: InputDecoration(
                          hintText: "Education",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Some Text";
                          } else {
                            return null;
                          }
                        },
                        controller: _.cityController,
                        decoration: InputDecoration(
                          hintText: "City Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        controller: _.phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Phone Number";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Phone Num",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
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
                        controller: _.emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Some Text";
                          } else {
                            return null;
                          }
                        },
                        controller: _.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const SizedBox(height: 15,),
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blueAccent
                        ),
                        child: TextButton(
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ), onPressed: () async {
                          print("sigin up button click");
                          if (_.formsignup.currentState!.validate()) {
                            print("form state run");
                              await _.uploadUserProfileImage();
                            print("upload function run");
                            await FireAuth.signupUser(
                                education: _.eduController.text,
                                urlprofileimage: _.urlSelectedImage,
                                name: _.nameController.text,
                                email: _.emailController.text,
                                city: _.cityController.text,
                                company: _.companyController.text,
                                password: _.passwordController.text,
                                phoneNumber: _.phoneNumberController.text
                            );
                            print("sign up function  run");
                            final snackBar = SnackBar(
                              content: const Text('Successfull SignUp'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                            _.nameController.clear();
                            _.emailController.clear();
                            _.cityController.clear();
                            _.companyController.clear();
                            _.passwordController.clear();
                            _.phoneNumberController.clear();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FbScreen()));
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Something Wrong'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          }
                        }
                        ),

                      ),
                      const SizedBox(height: 10,),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Text("All ready have account:"),
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                          }, child: Text("Log In"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}