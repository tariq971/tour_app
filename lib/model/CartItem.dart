class CartItem{
  String productId;
  String userId;
  int quantity;

  CartItem(this.productId, this.userId, this.quantity);

  String getId(){
    return userId+productId;
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    CartItem p= CartItem(map['productId'], map['userId'], map['quantity']);
    return p;
  }

  Map<String, dynamic> toMap() {
    return {'productId': productId, 'userId': userId, 'quantity': quantity, };
  }
}