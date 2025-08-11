import 'package:get/get.dart';
import 'package:mad_2_211/model/product.dart';

class ProductService extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void addProduct(Product product) {
    products.add(product);
  }
}
