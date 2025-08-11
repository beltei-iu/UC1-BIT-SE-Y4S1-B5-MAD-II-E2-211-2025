import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/screens/main_screen.dart';

class FirebaseAuthService {
  static FirebaseAuthService _instance = FirebaseAuthService._init();

  static FirebaseAuthService get instance => _instance;

  FirebaseAuthService._init();

  Future<void> signInFirebaseWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential user) {
          print("User : $user");
          Get.offAll(MainScreen());
        })
        .catchError((error) {
          print("Error catchError : $error");
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: error.toString(),
              icon: const Icon(Icons.refresh),
              duration: const Duration(seconds: 3),
            ),
          );
        });
  }

  Future<void> signOutFromFacebook() async {
    await FirebaseAuth.instance.signOut();
  }
}
