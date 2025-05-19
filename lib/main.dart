import 'package:flutter/material.dart';
import 'package:mad_2_211/screens/home_screen.dart';
import 'package:mad_2_211/screens/login_screen.dart';

void main() {

  // This is the entry point of the application.
  WidgetsFlutterBinding.ensureInitialized();

  final app = App();
  runApp(app);
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
      home: LoginScreen(),
    );
  }
}