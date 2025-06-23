
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/screens/main_screen.dart';
import 'package:mad_2_211/screens/otp_screen.dart';
import 'package:mad_2_211/screens/phone_screen.dart';
import 'package:mad_2_211/screens/register_screen.dart';
import 'package:mad_2_211/screens/splash_screen.dart';

class AppRoute {

  static const String splashScreen = "";
  static const String loginScreen = "/loginScreen";
  static const String registerScreen = "/registerScreen";
  static const String mainScreen = "/mainScreen";
  static const String phoneScreen = "/phoneScreen";
  static const String otpScreen = "/otpScreen";

 static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings){

    switch(routeSettings.name){
      case splashScreen: 
          return _buildRoute(routeSettings,SplashScreen());
      case loginScreen:
        return _buildRoute(routeSettings,LoginScreen());
      case registerScreen:
        return _buildRoute(routeSettings,RegisterScreen());
      case mainScreen:
        return _buildRoute(routeSettings,MainScreen());
      case phoneScreen:
        return _buildRoute(routeSettings, PhoneScreen());
      case otpScreen:
        return _buildRoute(routeSettings, OtpScreen());
      default:
         throw RouteException("Route not found.");
    }
  }

  static Route<dynamic> _buildRoute(RouteSettings routeSettings, Widget newRoute){
    final route = MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) => newRoute);
    return route;
  }

}

class RouteException implements Exception {

  String messsage;

  RouteException(this.messsage);

}