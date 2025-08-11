import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mad_2_211/main.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(11.5476901, 104.9142898),
        infoWindow: InfoWindow(title: 'Googleplex'),
      ),
    };

    return Scaffold(
      appBar: AppBar(title: Text("Product Detail"), centerTitle: true),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/shue1.jpg',
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          SizedBox(
            height: 500,
            width: double.infinity,
            child: GoogleMap(
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(11.5476901, 104.9142898),
                zoom: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
