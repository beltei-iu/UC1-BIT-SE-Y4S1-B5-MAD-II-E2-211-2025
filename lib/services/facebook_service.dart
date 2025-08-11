import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/screens/main_screen.dart';

class FacebookService {
  static FacebookService _instance = FacebookService._init();

  static FacebookService get instance => _instance;

  FacebookService._init();

  Future<void> signInWithFacebook() async {
    List<String> permissions = ['email', 'public_profile'];

    final LoginResult result = await FacebookAuth.instance.login(
      permissions: permissions,
      loginBehavior: LoginBehavior.dialogOnly,
    );
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken!.tokenString,
      );
      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      if (userCredential.user != null) {
        Get.offAll(MainScreen());
      }
    }
  }

  Future<void> signOutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> _isFacebookLoggedIn() async {
    await FacebookAuth.instance.logOut();
    final token = await FacebookAuth.instance.accessToken;
    return token != null;
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final userData = await FacebookAuth.instance.getUserData(
      fields: "email,name",
    );
    return userData;
  }
}
