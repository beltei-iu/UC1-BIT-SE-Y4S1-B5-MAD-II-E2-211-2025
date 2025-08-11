import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/controllers/theme_controller.dart';
import 'package:mad_2_211/screens/account_screen.dart';
import 'package:mad_2_211/screens/language_screen.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/screens/theme_screen.dart';
import 'package:mad_2_211/services/facebook_service.dart';
import 'package:mad_2_211/services/google_service.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _navigationToAccountScreen() async {
    bool isFacebookLogIn = await FacebookService.instance.isFacebookLoggedIn();
    bool isGoogleSignIn = await GoogleService.instance.isGoogleSignIn();
    if (isFacebookLogIn || isGoogleSignIn) {
      Get.to(AccountScreen());
    } else {
      Get.off(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("more".tr),
        elevation: 0.2,
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text("language".tr),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(LanguageScreen());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.newspaper),
                  title: Text("Theme"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(ThemeScreen());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Account"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _navigationToAccountScreen();
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Get.off(LoginScreen());
  }
}
