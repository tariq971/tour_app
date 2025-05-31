import 'package:tour_app/model/OrderItem.dart';

class Order {
  String id;
  String customerId;
  String uId;
  String customerName;
  String? status="pending";

  List<OrderItem> orderItems = [];

  Order(this.id, this.customerId, this.uId, this.customerName);

  int getGrandTotal(){
  return orderItems.fold(0, (previousValue,element)=> previousValue+element.price*element.quantity,);
  }

  static Order fromMap(Map<String, dynamic> map) {
    Order p = Order(
      map["id"],
      map["customerId"],
      map["uId"],
      map["customerName"],
    );
    p.status=map["status"];
    p.orderItems =
        (map["orderItem"] as List)
            .map((e) => OrderItem.fromMap(e as Map<String, dynamic>))
            .toList();
    return p;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customerId": customerId,
      "uId": uId,
      "customerName": customerName,
      "status":status,
      "orderItems": orderItems.map((e) => e.toMap()).toList(),
    };
  }
}
