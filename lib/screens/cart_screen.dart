import 'package:flutter/material.dart';
import 'package:mad_2_211/screens/custom_search_delegate.dart';
import 'package:mad_2_211/services/order_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: OrderService.getOrder(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No favorite items found."));
          } else {
            List<String> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                String order = orders[index];
                final orderDetails = order.split(',');
                String productId = orderDetails[0].split('=')[1];
                String price = orderDetails[1].split('=')[1];
                String qty = orderDetails[2].split('=')[1];
                String discount = orderDetails[3].split('=')[1];

                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/shue1.jpg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      "$productId - Price: $price, Qty: $qty, Discount: $discount",
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
