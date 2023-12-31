import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reserve_vol/screens/home_page.dart';
import 'package:reserve_vol/screens/login_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //? tverifie ykan l'app vih deja userData tgiss directement home screen
          if (snapshot.hasData) {
            // return homeScreen();
            return LoginScreen();

          }
          //? Si non return chor loginPage
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
