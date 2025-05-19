
import 'package:flutter/material.dart';
import 'package:mad_2_211/screens/account_screen.dart';
import 'package:mad_2_211/screens/cart_screen.dart';
import 'package:mad_2_211/screens/favorite_screen.dart';
import 'package:mad_2_211/screens/home_screen.dart';

class MainScreen extends StatefulWidget {

  
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    AccountScreen()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: _bottomNavBar,
    );
  }

  Widget get _body {
    return _screens[_selectedIndex];
  }

  Widget get _bottomNavBar {

    final bottonNavBarItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
    ];

    return BottomNavigationBar(
      items: bottonNavBarItems,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}