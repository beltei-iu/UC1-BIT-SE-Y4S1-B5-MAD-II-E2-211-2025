import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/controllers/theme_controller.dart';
import 'package:mad_2_211/screens/language_screen.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  onTap: () {},
                ),
                Divider(),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                _signOut();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Logout", style: TextStyle(color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.logout, color: Colors.white),
                  ),
                ],
              ),
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
