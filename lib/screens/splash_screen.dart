import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/screens/main_screen.dart';
import 'package:mad_2_211/services/facebook_service.dart';
import 'package:mad_2_211/services/google_service.dart';
import 'package:mad_2_211/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              child: LogoWidget(),
            ),
          ),
          _getStart(context),
          _getGuest(context),
        ],
      ),
    );
  }

  Widget _getStart(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            _navigationGetStart();
          },
          child: Text(
            "Get start",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getGuest(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            // Route to Main Screen
            Get.off(MainScreen());
            //Navigator.of(context).pushReplacementNamed(AppRoute.mainScreen);
          },
          child: Text(
            "Continue as Guest",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Future<void> _navigationGetStart() async {
    bool isFacebookLogIn = await FacebookService.instance.isFacebookLoggedIn();
    bool isGoogleSignIn = await GoogleService.instance.isGoogleSignIn();
    if (isFacebookLogIn || isGoogleSignIn) {
      Get.off(MainScreen());
    } else {
      Get.off(LoginScreen());
    }
  }
}
