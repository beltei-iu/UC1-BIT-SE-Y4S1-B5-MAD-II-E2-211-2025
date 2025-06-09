import 'package:flutter/material.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/screens/custom_search_delegate.dart';
import 'package:mad_2_211/services/order_service.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "Guest";
  int _totalOrder = 0;

  void initState() {
    super.initState();
    _fetchFullName();
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    OrderService.getOrder().then((value) {
      setState(() {
        _totalOrder = value.length;
      });
    });
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
          badges.Badge(
            badgeContent: Text(
              "${_totalOrder}",
              style: TextStyle(color: Colors.white),
            ),
            position: badges.BadgePosition.topEnd(top: 10, end: 10),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
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
      body: ListView(
        children: [
          _exploredWidget,
          _slideWidget,
          _topProductsWidget,
          _topProductsListWidget,
        ],
      ),
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

  Widget get _topProductsWidget {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.arrow_forward, color: Colors.grey),
        ],
      ),
    );
  }

  Widget get _topProductsListWidget {
    final cardProducts = List.generate(10, (index) {
      return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              height: 310,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/shue1.jpg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    //"Men's New Fashion leather shoes men's large size business suits men's shoes creative trend fashion foreign trade shoes men's singles
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        "Men's New Fashion leather shoes men's large size ...",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "12\$",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text("4.5", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              OrderService.order(index, 1, 12, 10);
                              final alert = AlertDialog(
                                title: Text("Order Placed"),
                                content: Text(
                                  "Your order for product ID $index has been placed successfully!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => alert,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text("1"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });

    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: cardProducts),
      ),
    );
  }
}
