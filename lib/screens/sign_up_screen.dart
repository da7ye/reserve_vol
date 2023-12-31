import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reserve_vol/screens/home_page.dart';
import 'package:reserve_vol/screens/login_screen.dart';
import 'package:reserve_vol/widget/my_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ?register fonction
  void signUserUp() async {
    showDialog(
      // ?tna3at loading cercle
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // ?tajouti le nouveau donnees dans le database comme user wtgiss homePage() s'il n'ya pas d'ereur
    try {
      {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
        Get.offAll(() => homeScreen()); 
      }
  // ?    en cas d'ereur
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.rotate(
                      angle: 3.14 / 4,
                      child: Icon(Icons.airplanemode_active, size: 48),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 2,
                      color: Colors.black,
                      margin: EdgeInsets.only(
                        bottom: 16,
                        right: MediaQuery.of(context).size.width / 3,
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              controller: nameController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter Email',
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              // obscureText: true,
                              controller: emailController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              obscureText: true,
                              controller: passwordController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    MyButton(
                      onPressed: () {
                        signUserUp();
                        Get.to(() => homeScreen());
                      },
                      title: 'Se Connecter',
                      // You can customize buttonColor as needed
                      buttonColor: Color(0xFF0044A5),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Sign-in',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
