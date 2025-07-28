import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/controllers/cart_controller.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/model/order.dart';
import 'package:mad_2_211/provider/cart_provider.dart';
import 'package:mad_2_211/screens/custom_search_delegate.dart';
import 'package:mad_2_211/services/category_service.dart';
import 'package:mad_2_211/services/order_service.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../model/category.dart' show Category;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "Guest";
  int _totalOrder = 0;
  List<Category> categories = [];
  final orderService = OrderService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    _fetchFullName();
    _loadCategoryMenu();
  }

  Future<void> _loadCategoryMenu() async {
    final categoryService = CategoryService();
    List<Category> categoryList = await categoryService.retrieveCategory();
    setState(() {
      categories = categoryList;
    });
  }

  Future<void> _loadOrder() async {
    // final cartProvider = Provider.of<CartProvider>(context, listen: true);
    // setState(() {
    //   _totalOrder = cartProvider.orders.length;
    // });

    // orderService.getOrder().then((value) {
    //   print("Total order  : ${value.length}", );
    //   setState(() {
    //     _totalOrder = value.length;
    //   });
    // });
  }

  Future<void> _fetchFullName() async {
    //String? name = await UserSharedPreference.getUserData("fullName");

    String? name = await _auth.currentUser?.email;
    if (name != null) {
      setState(() {
        fullName = name;
      });
    }
  }

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    // This is where you can fetch the full name from shared preferences
    print("Full Name: $fullName");

    // final cartProvider = Provider.of<CartProvider>(context, listen: true);

    List<Order> orders = cartController.orders;
    setState(() {
      _totalOrder = orders.length;
    });

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
          _buildMenu,
          _slideWidget,
          _topProductsWidget,
          _topProductsListWidget(),
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
            "hi".tr + " " + fullName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget get _buildMenu {
    List<Widget> menuList =
        categories.map((i) {
          return TextButton(onPressed: () {}, child: Text("${i.name}"));
        }).toList();

    // Option1
    Widget option1 = SizedBox(
      height: 50,
      child: ListView(scrollDirection: Axis.horizontal, children: menuList),
    );

    // Option2
    Widget option2 = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: menuList),
    );

    return option2;
  }

  Widget get _slideWidget {
    // return Padding(
    //   padding: EdgeInsets.only(left: 16, right: 16, top: 16),
    //   child: Image.asset(
    //     'assets/images/HQ.png',
    //     height: 200,
    //     fit: BoxFit.cover,
    //   ),
    // );
    return SizedBox(
      height: 180,
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: double.infinity,
        children: List<Widget>.generate(10, (int index) {
          return Image.asset(
            'assets/images/HQ.png',
            height: 200,
            fit: BoxFit.cover,
          );
        }),
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
            "ផលិតផលថ្មី",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text("បន្ថែម"),
              Icon(Icons.arrow_forward, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _topProductsListWidget() {
    final cardProducts = List.generate(10, (index) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/productDetailScreen');
        },
        child: Padding(
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
                                final order = Order(
                                  productId: index,
                                  price: 200,
                                  quantity: 1,
                                );
                                // orderService.insertOrder(order);
                                //cartProvider.addOrder(order);
                                cartController.addOrder(order);

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
