import 'package:flutter/material.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/screens/custom_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "Guest";

  void initState() {
    super.initState();
    _fetchFullName();
  }

  Future<void> _fetchFullName() async {
    String? name = await UserSharedPreference.getUserData("fullName");

    if (name != null) {
      setState(() {
        fullName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is where you can fetch the full name from shared preferences
    print("Full Name: $fullName");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            child: Icon(Icons.search, color: Colors.black),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(children: [_exploredWidget, _slideWidget]),
    );
  }

  Widget get _exploredWidget {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, $fullName",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget get _slideWidget {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Image.asset(
        'assets/images/HQ.png',
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
