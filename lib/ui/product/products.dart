import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/ui/product/view_models/products_vm.dart';

import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../data/product_repository.dart';
import '../../model/Product.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductsViewModel productsViewModel;

  @override
  void initState() {
    super.initState();
    productsViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed('/addProduct');
          if (result == true) {
            Get.snackbar("Product saved", "Product saved successfully");
          }
        },
        child: Icon(Icons.add),
      ),
      body: Obx(
            () {
          return ListView.builder(
            itemCount: productsViewModel.products.length,
            itemBuilder: (context, index) {
              Product product = productsViewModel.products[index];
              return ListTile(
                onLongPress: () {
                  Get.dialog(AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: const Text('Edit'),
                            onPressed: () {
                              Get.back();
                              Get.toNamed('/addProduct',arguments: product);
                            },
                          ),
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              Get.back();
                              productsViewModel.deleteProduct(product);
                            },
                          )
                        ],)
                  ));
                },
                leading: product.image==null?Icon(Icons.image,size: 80,):Image.network(product.image!,height: 80,width: 80,),
                trailing: TextButton(onPressed: () {
                  productsViewModel.addToCart(product);
                }, child: Text("Add to cart")),
                title: Text(product.name),
                subtitle: Text(product.price.toString()),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(CartItemRepository());
    Get.put(ProductsViewModel());
  }
}
