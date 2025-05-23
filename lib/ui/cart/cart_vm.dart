import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../data/product_repository.dart';
import '../../model/CartItem.dart';

class CartViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  CartItemRepository cartItemRepository = Get.find();
  var isLoading = false.obs;
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllCartItems();
  }

  void loadAllCartItems() {
    cartItemRepository
        .loadCartItemOfUser(authRepository.getLoggedInUser()!.uid)
        .listen(
      (data) {
        cartItems.value = data;
      },
    );
  }

  Future<void> deleteCartItem(CartItem cartItem) async {
    await cartItemRepository.deleteCartItem(cartItem);
  }

  incrementQuantity(CartItem cartItem) {
    cartItem.quantity = cartItem.quantity + 1;
    cartItemRepository.updateCartItem(cartItem);
  }
  decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity == 1) {
      Get.dialog(AlertDialog(
        title: Text("Remove item?"),
        content: Text("Do you want to remove this item from cart?"),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("No")),
          TextButton(
              onPressed: () {
                cartItemRepository.deleteCartItem(cartItem);
                Get.back();
              },
              child: Text("Yes")),
        ],
      ));

      return;
    }
    cartItem.quantity = cartItem.quantity - 1;
    cartItemRepository.updateCartItem(cartItem);
  }
}
