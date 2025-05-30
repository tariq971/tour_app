import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tour_app/model/CartItemWithProduct.dart';

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
          return Column(
            children: [
          Expanded(
            child: ListView.builder(
            itemCount: cartViewModel.cartItems.length,
              itemBuilder: (context, index) {
                CartItemWithProduct cartItemWithProduct = cartViewModel.cartItems[index];
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
                                cartViewModel.deleteCartItem(cartItemWithProduct.cartItem);
                              },
                            )
                          ],)
                    ));
                  },
                  title: Text(cartItemWithProduct.product.name),
                  leading: cartItemWithProduct.product.image==null?Icon(Icons.image,size: 80,):Image.network(cartItemWithProduct.product.image!,height: 80,width: 80,),

                  trailing: Column(
                    children: [
                      Text("Rs. ${cartItemWithProduct.product.price}"),
                      Text("Rs. ${cartItemWithProduct.getTotal()}")
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      IconButton(onPressed: () => cartViewModel.decrementQuantity(cartItemWithProduct.cartItem), icon: Icon(Icons.remove)),
                      Text(cartItemWithProduct.cartItem.quantity.toString()),
                      IconButton(onPressed: () => cartViewModel.incrementQuantity(cartItemWithProduct.cartItem), icon: Icon(Icons.add)),

                    ],
                  ),

                );
              },
            ),
          ),
              Row(
                children: [
                  Expanded(child: Text("Total: ${cartViewModel.getGrandTotal()}")),
                  ElevatedButton(onPressed: (){}, child:Text("Checkout"))
                ],
              )
            ],

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
