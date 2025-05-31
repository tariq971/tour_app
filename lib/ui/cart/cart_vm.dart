import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/data/order_repository.dart';
import 'package:tour_app/model/CartItemWithProduct.dart';
import 'package:tour_app/model/Order.dart';
import 'package:tour_app/model/OrderItem.dart';

import '../../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../data/product_repository.dart';
import '../../model/CartItem.dart';

class CartViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  CartItemRepository cartItemRepository = Get.find();
  OrderRepository orderRepository = Get.find();
  var isLoading = false.obs;
  var cartItems = <CartItemWithProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllCartItems();
  }

  int getGrandTotal() {
    int total = 0;
    for (var item in cartItems.value) {
      total += item.getTotal();
    }
    return total;
  }

  Future<void> loadAllCartItems() async {
    var products = await productsRepository.loadAllProductsOnce();
    var productsMap = {for (var p in products) p.id: p};
    cartItemRepository
        .loadCartItemOfUser(authRepository.getLoggedInUser()!.uid)
        .listen((data) {
          cartItems.value =
              data
                  .where((e) => productsMap.containsKey(e.productId))
                  .map((e) => CartItemWithProduct(e, productsMap[e.productId]!))
                  .toList();
        });
  }

  Future<void> checkOut() async {
    if (cartItems.value.length == 0) {
      Get.snackbar("Empty cart", "Cannot checkout empty cart ");
      return;
    }
    Order order = Order(
      "",
      authRepository.getLoggedInUser()!.uid,
      cartItems.value[0].product.uId,
      authRepository.getLoggedInUser()!.displayName ?? " ",
    );
    order.orderItems =
        cartItems.value
            .map(
              (e) => OrderItem(
                e.product.name,
                e.product.price,
                e.product.image,
                e.cartItem.quantity,
              ),
            )
            .toList();

    try {
      isLoading.value = true;
      await orderRepository.addOrder(order);
    } catch (e) {
      Get.snackbar("Error", "Error creation order ${e.toString()}");
      isLoading.value=false;
      return;
    }
    await cartItemRepository.clearCart(authRepository.getLoggedInUser()!.uid);
    isLoading.value = false;
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
      Get.dialog(
        AlertDialog(
          title: Text("Remove item?"),
          content: Text("Do you want to remove this item from cart?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                cartItemRepository.deleteCartItem(cartItem);
                Get.back();
              },
              child: Text("Yes"),
            ),
          ],
        ),
      );

      return;
    }
    cartItem.quantity = cartItem.quantity - 1;
    cartItemRepository.updateCartItem(cartItem);
  }
}
