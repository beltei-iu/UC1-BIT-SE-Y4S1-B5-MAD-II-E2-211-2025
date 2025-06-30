
import 'package:flutter/material.dart';
import 'package:mad_2_211/main.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/shue1.jpg',
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
