import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mad_2_211/controllers/theme_controller.dart';
import 'package:mad_2_211/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mad_2_211/data/file_storage_manager.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/screens/home_screen.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/screens/otp_screen.dart';
import 'package:mad_2_211/screens/splash_screen.dart';
import 'package:mad_2_211/model/category.dart';
import 'package:mad_2_211/services/category_service.dart';

import 'data/db_manager.dart';

void main() async{
  // This is the entry point of the application.
  WidgetsFlutterBinding.ensureInitialized();
  // Load Storage
  await GetStorage.init();

  // Init DB
  if(Platform.isWindows){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }else{
    await DbManager.instance?.database;
  }

  // Insert Data
  // List<String> categoryItems = ["Electronics","Toys","Clothes","Shoes","Books"];
  //final categoryService = CategoryService();
  // for (var item in categoryItems) {
  //   final category = Category(name: item, nameKm: item);
  //   categoryService.insertCategory(category);
  // }

  // Config Provider
  // final provider = MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) => CartProvider()),
  //     // Can add other provider
  //   ],
  //   child: App(),
  // );

  runApp(App());
}

Future<void> readDataFromAsset() async {
  final file = await rootBundle.loadString('assets/data/data.txt');
  print("Data from asset: $file");
}

Future<void> writeDataFromAsset() async {
  final file = File('assets/data/data.txt').openWrite(mode: FileMode.append);
  file.writeln('This is a new data file for MAD-II-211');
  print("Data from asset: $file");
}

Future<void> loadFile() async {
  File data = await FileStorageManager.getFile(FileStorageManager.fileName);
  print("File path: ${data.path}");
  print("Data file : ${data.readAsStringSync()}");
}

class App extends StatelessWidget {

  final ThemeController  themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD-II-211',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      // ),
      // initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
      home: SplashScreen(),

      // Theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.theme,
    );
  }
}
