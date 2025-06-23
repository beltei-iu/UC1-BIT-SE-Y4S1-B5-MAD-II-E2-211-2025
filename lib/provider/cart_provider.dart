
import 'package:flutter/material.dart';
import 'package:mad_2_211/data/db_manager.dart';
import 'package:mad_2_211/model/order.dart';
import 'package:provider/provider.dart';

import '../services/order_service.dart' show OrderService;

class CartProvider extends ChangeNotifier {

  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> addOrder(Order order) async {
    final orderService = OrderService();
    await orderService.insertOrder(order);
    List<Order> orders = await orderService.getOrder();
    _orders = orders;
    notifyListeners();
  }
}