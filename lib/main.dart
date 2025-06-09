import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mad_2_211/data/file_storage_manager.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/screens/home_screen.dart';
import 'package:mad_2_211/screens/login_screen.dart';
import 'package:mad_2_211/screens/otp_screen.dart';
import 'package:mad_2_211/screens/splash_screen.dart';

void main() {
  // This is the entry point of the application.
  WidgetsFlutterBinding.ensureInitialized();

  final app = App();
  runApp(app);
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
    );
  }
}
