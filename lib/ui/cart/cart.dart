import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../data/product_repository.dart';
import '../../model/CartItem.dart';
import 'cart_vm.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartViewModel cartViewModel;

  @override
  void initState() {
    super.initState();
    cartViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return ListView.builder(
            itemCount: cartViewModel.cartItems.length,
            itemBuilder: (context, index) {
              CartItem cartItem = cartViewModel.cartItems[index];
              return ListTile(
                onLongPress: () {
                  Get.dialog(AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          Get.back();
                          cartViewModel.deleteCartItem(cartItem);
                        },
                      )
                    ],)
                  ));
                },
                title: Text(cartItem.productId),
                subtitle: Row(
                  children: [
                    IconButton(onPressed: () => cartViewModel.decrementQuantity(cartItem), icon: Icon(Icons.remove)),
                    Text(cartItem.quantity.toString()),
                    IconButton(onPressed: () => cartViewModel.incrementQuantity(cartItem), icon: Icon(Icons.add)),

                  ],
                ),

              );
            },
          );
        },
      ),
    );
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(CartItemRepository());
    Get.put(CartViewModel());
  }
}
