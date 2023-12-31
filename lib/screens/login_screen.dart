import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserve_vol/screens/home_page.dart';
import 'package:reserve_vol/widget/my_button.dart';
import 'sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ? sign in utilisateur
  void signUserIn() async {
    // ?tna3at loading cercle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // ?Tfetchi le database yak tverifie les donnees user si exist tgiss homePage()
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
       Get.offAll(() => homeScreen()); 

    } on FirebaseAuthException catch (e) { //? si non treturni error message
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

// ?tna3at alert message si information 5asre wll na9sa
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.rotate(
                angle: 3.14 / 4,
                child: Icon(Icons.airplanemode_active, size: 48),
              ),
              SizedBox(
                  height: 15), 
              Text(
                'Connexion',
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
                  bottom:
                      16, 
                  right: MediaQuery.of(context).size.width / 3,
                ),
                width: MediaQuery.of(context).size.width / 3,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 50), 
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontSize: 25, 
                            ),
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                  signUserIn();
                },
                title: 'Se Connecter',
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Vous n\'avez pas de compte? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Inscrivez-vous ici',
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
    ));
  }
}
