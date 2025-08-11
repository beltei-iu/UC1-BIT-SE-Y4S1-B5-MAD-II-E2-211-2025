import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mad_2_211/screens/main_screen.dart';

class GoogleService {
  static GoogleService _instance = GoogleService._init();

  static GoogleService get instance => _instance;

  GoogleService._init();

  Future<void> signInWithGoogle() async {
    // SignIn Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // SignIn Auth
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // SignIn Firebase
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    if (userCredential.user != null) {
      Get.offAll(MainScreen());
    }
  }

  Future<bool> isGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    return googleAuth?.accessToken != null;
  }

  Future<void> signOutFromGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
