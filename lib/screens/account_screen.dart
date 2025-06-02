import 'package:flutter/material.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/route/app_route.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String fullName = "Guest";
  String? email = "";

  void initState() {
    super.initState();
    _fetchFullName();
  }

  Future<void> _fetchFullName() async {
    String? name = await UserSharedPreference.getUserData("fullName");
    email = await UserSharedPreference.getUserData("email");

    if (name != null) {
      setState(() {
        fullName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/user-profile2.jpg',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "$fullName",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "$email",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                logoutHandler();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void logoutHandler() {
    UserSharedPreference.logout();
    AppRoute.key.currentState?.pushReplacementNamed(AppRoute.splashScreen);
  }
}
