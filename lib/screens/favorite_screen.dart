import 'package:flutter/material.dart';
import 'package:mad_2_211/services/order_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        centerTitle: true,
        backgroundColor: Colors.red,
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
