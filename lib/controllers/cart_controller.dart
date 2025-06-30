
import 'package:get/get.dart';
import 'package:mad_2_211/model/order.dart';
import 'package:mad_2_211/services/order_service.dart';

class CartController extends GetxController {

  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> addOrder(Order order) async {
    final orderService = OrderService();
    await orderService.insertOrder(order);
    List<Order> orders = await orderService.getOrder();
    _orders = orders;
  }

  Future<void> removeCart(Order order) async{
    final orderService = OrderService();
    await orderService.deleteOrder(order);
  }
}