
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "Hi, Chivon",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}