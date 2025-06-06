import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/CartItem.dart';

class CartItemRepository {
  late CollectionReference CartItemCollection;

  CartItemRepository() {
    CartItemCollection = FirebaseFirestore.instance.collection('cartItem');
  }

  Future<void> updateCartItem(CartItem cartItem) {
    return CartItemCollection.doc(cartItem.getId()).set(cartItem.toMap());
  }

  Future<void> deleteCartItem(CartItem cartItem) {
    return CartItemCollection.doc(cartItem.getId()).delete();
  }

  Future<void> clearCart(String userId) async {
    var items= await loadAllProductsOnce(userId);
    var batch = FirebaseFirestore.instance.batch();
    for(var item in items){
      batch.delete(CartItemCollection.doc(item.getId()));
    }
    await batch.commit();
  }

  Future<void> addCartItem(CartItem cartItem) {
    return CartItemCollection.doc(cartItem.getId()).set(cartItem.toMap());
  }

  Stream<List<CartItem>> loadCartItemOfUser(String userId) {
    return CartItemCollection.where('userId',isEqualTo: userId).snapshots().map(
      (snapshot) {
        return convertToCartItem(snapshot);
      },
    );
  }

  Future<List<CartItem>>loadAllProductsOnce(String userId) async {
    var snapshot= await CartItemCollection.where("userId",isEqualTo: userId).get();
    return convertToCartItem(snapshot);
  }

  // todo: check live listen
  AggregateQuery loadCartItemCount(String userId){
    return CartItemCollection.where('userId',isEqualTo: userId).count();
  }

  List<CartItem> convertToCartItem(QuerySnapshot snapshot){
    List<CartItem> cartItem=[];
    for (var snap in snapshot.docs) {
      cartItem.add(CartItem.fromMap(snap.data() as Map<String, dynamic>));
    }
    return cartItem;
  }
}
