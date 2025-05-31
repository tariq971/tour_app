import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Order.dart' as MyOrder;

class OrderRepository {
  late CollectionReference OrderCollection;

  OrderRepository() {
    OrderCollection = FirebaseFirestore.instance.collection('order');
  }

  Future<void> updateOrder(MyOrder.Order order) {
    return OrderCollection.doc(order.id).set(order.toMap());
  }

  Future<void> deleteOrder(MyOrder.Order order) {
    return OrderCollection.doc(order.id).delete();
  }

  Future<void> addOrder(MyOrder.Order order) {
    var doc = OrderCollection.doc();
    order.id=doc.id;
    return doc.set(order.toMap());
  }


  Stream<List<MyOrder.Order>> loadOrderOfUser(String userId) {
    return OrderCollection.where('uId',isEqualTo: userId).snapshots().map(
      (snapshot) {
        return convertToOrder(snapshot);
      },
    );
  }

  Stream<List<MyOrder.Order>> loadOrderOfShop(String userId) {
    return OrderCollection.where('userId',isEqualTo: userId).snapshots().map(
      (snapshot) {
        return convertToOrder(snapshot);
      },
    );
  }


  AggregateQuery loadOrderCount(String userId){
    return OrderCollection.where('userId',isEqualTo: userId).count();
  }

  List<MyOrder.Order> convertToOrder(QuerySnapshot snapshot){
    List<MyOrder.Order> order=[];
    for (var snap in snapshot.docs) {
      order.add(MyOrder.Order.fromMap(snap.data() as Map<String, dynamic>));
    }
    return order;
  }
}
