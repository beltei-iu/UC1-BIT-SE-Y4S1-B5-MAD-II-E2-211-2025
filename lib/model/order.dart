
class Order {
  int? id;
  int? productId;
  int? quantity;
  double? price;

  Order({this.id, this.productId, this.quantity, this.price});

  factory Order.fromMap(Map<String, dynamic> map) => Order(
      id: map['id'],
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price']
  );

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'productId':productId,
      'quantity':quantity,
      'price': price
    };
  }
}