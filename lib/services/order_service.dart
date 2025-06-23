import 'dart:io';

import 'package:mad_2_211/data/db_manager.dart';
import 'package:mad_2_211/model/order.dart';
import 'package:sqflite/sqflite.dart';

class OrderService {

  Future<void> insertOrder(Order order) async {

    // Write to File
    // final file = File('assets/data/data.txt').openWrite(mode: FileMode.append);
    // // productId=2,price=4,qty=1,discount=20
    // String data =
    //     "product=${productId},price=${price},qty=${qty},discount=${discount}";
    // file.writeln(data);
    // print("Data from asset: $file");


    // Write to DB
    final db = await DbManager.instance!.database;
    await db.insert(DbManager.ORDER_TABLE_NAME, order.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Order>> getOrder() async {

    // Read from File
    // final file = File('assets/data/data.txt');
    // if (await file.exists()) {
    //   List<String> lines = await file.readAsLines();
    //   return lines;
    // } else {
    //   return [];
    // }

    // Read from DB
    final db = await DbManager.instance!.database;
    final List<Map<String , dynamic>> results = await db.query(DbManager.ORDER_TABLE_NAME);
    // Option 1
    return List.generate(results.length, (i) => Order.fromMap(results[i]));
    // Option 2
    // return results.map((e) => Order.fromMap(e)).toList();
  }
}
