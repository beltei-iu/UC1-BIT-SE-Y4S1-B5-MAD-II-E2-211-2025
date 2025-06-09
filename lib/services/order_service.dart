import 'dart:io';

class OrderService {
  static Future<void> order(
    int productId,
    int qty,
    double price,
    int discount,
  ) async {
    final file = File('assets/data/data.txt').openWrite(mode: FileMode.append);
    // productId=2,price=4,qty=1,discount=20
    String data =
        "product=${productId},price=${price},qty=${qty},discount=${discount}";
    file.writeln(data);
    print("Data from asset: $file");
  }

  static Future<List<String>> getOrder() async {
    final file = File('assets/data/data.txt');
    if (await file.exists()) {
      List<String> lines = await file.readAsLines();
      return lines;
    } else {
      return [];
    }
  }
}
