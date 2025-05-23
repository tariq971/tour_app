import 'package:tour_app/model/CartItem.dart';
import 'package:tour_app/model/Product.dart';

class CartItemWithProduct {
  CartItem cartItem;
  Product product;
  CartItemWithProduct(this.cartItem, this.product);

  int getTotal(){
    return product.price*cartItem.quantity;
  }
}