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
        // Update Profile from Facebook
        Map<String, dynamic> userData = await _getUserData();
        String photoURL = userData['picture']['data']['url'];
        await userCredential.user!.updatePhotoURL(photoURL);

        Get.offAll(MainScreen());
      } else {
        Get.snackbar("Error", "Something went wrong");
      }
    } else if (result.status == LoginStatus.cancelled) {
      Get.snackbar("Error", "Login cancelled");
    } else {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  Future<void> signOutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> isFacebookLoggedIn() async {
    final token = await FacebookAuth.instance.accessToken;
    return token != null;
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final userData = await FacebookAuth.instance.getUserData(
      fields: "email,name,picture.width(200)",
    );
    return userData;
  }
}
