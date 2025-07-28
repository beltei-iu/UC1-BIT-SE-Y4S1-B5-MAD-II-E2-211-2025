import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/controllers/cart_controller.dart';
import 'package:mad_2_211/model/order.dart';
import 'package:mad_2_211/screens/custom_search_delegate.dart';
import 'package:mad_2_211/services/order_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final orderService = OrderService();

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart".tr),
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
        future: orderService.getOrder(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No favorite items found."));
          } else {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {

                Order order = orders[index];
                // final orderDetails = order.split(',');
                // String productId = orderDetails[0].split('=')[1];
                // String price = orderDetails[1].split('=')[1];
                // String qty = orderDetails[2].split('=')[1];
                // String discount = orderDetails[3].split('=')[1];

                return Dismissible(
                    key: ValueKey<int>(order.id!),
                    // confirmDismiss: (DismissDirection direction){
                    //
                    // },
                    onDismissed: (direction) {
                        cartController.removeCart(order);
                    },
                    child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/shue1.jpg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      "${order.productId} - Price: ${order.price}, Qty: ${order.quantity}, Discount: ${order.price}",
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  ),
                ));
              },
            );
          }
        },
      ),
    );
  }
}
