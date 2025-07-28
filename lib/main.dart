import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mad_2_211/controllers/theme_controller.dart';
import 'package:mad_2_211/firebase_options.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/screens/splash_screen.dart';
import 'package:mad_2_211/translate/Message.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'data/db_manager.dart';

void main() async {
  // This is the entry point of the application.
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Configure
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load Storage
  // await GetStorage.init();
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  } else {
    await DbManager.instance?.database;
  }
  runApp(App());
}

class App extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD-II-211',
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
      home: SplashScreen(),

      // Theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.theme,

      translations: Message(),
      locale: Locale("en", "US"),
      fallbackLocale: Locale("en", "US"),
    );
  }
}
