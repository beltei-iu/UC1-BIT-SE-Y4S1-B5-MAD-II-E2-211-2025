import 'dart:io';
import 'package:flutter/foundation.dart';
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

  // Init DB
  await DbManager.instance?.database;
  // sqfliteFfiInit();
  // var databaseFactory = databaseFactoryFfi;


  // Insert Data
  // List<String> categoryItems = ["Electronics","Toys","Clothes","Shoes","Books"];
  //final categoryService = CategoryService();
  // for (var item in categoryItems) {
  //   final category = Category(name: item, nameKm: item);
  //   categoryService.insertCategory(category);
  // }


  // Config Provider
  final provider = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      // Can add other provider
    ],
    child: App(),
  );

  runApp(provider);
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
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD-II-211',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
    );
  }
}
