import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/services/facebook_service.dart';
import 'package:mad_2_211/services/google_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String fullName = "Guest";
  String? email = "";
  String? picture;
  bool _loadingProfile = false;

  void initState() {
    super.initState();
    _fetchFullName();
  }

  Future<void> _fetchFullName() async {
    final user = await FirebaseAuth.instance.currentUser;
    print("CurrentUser : $user");
    if (user != null) {
      setState(() {
        fullName = user.displayName!;
        email = user.email;
        picture = user.photoURL;
        _loadingProfile = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.navigate_before, color: Colors.white),
        title: Text("Account", style: TextStyle(color: Colors.white)),
        elevation: 0.2,
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 16)),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _loadingProfile
                            ? NetworkImage(picture!)
                            : AssetImage("assets/images/user-profile.jpg"),
                  ),
                  ListTile(
                    title: Text("Full Name"),
                    subtitle: Text("$fullName"),
                  ),
                  Divider(),
                  ListTile(title: Text("Email"), subtitle: Text("$email")),
                  Divider(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _logoutHandler();
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logoutHandler() async {
    await FacebookService.instance.signOutFromFacebook();
    await GoogleService.instance.signOutFromGoogle();
    Get.offAll(LoginScreen());
  }
}
