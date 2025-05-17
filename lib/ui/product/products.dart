import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/model/Product.dart';
import 'package:tour_app/ui/product/view_models/products_vm.dart';

import '../../data/AuthRepository.dart';
import '../../data/product_repository.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsViewModel = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed("/addProduct");
          if (result == true) {
            Get.snackbar("Success", "Product saved successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white);
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        if (productsViewModel.products.isEmpty) {
          return const Center(
            child: Text("No products yet. Tap + to add one!"),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: productsViewModel.products.length,
          itemBuilder: (context, index) {
            Product product = productsViewModel.products[index];
            return _buildProductListItem(product, productsViewModel);
          },
        );
      }),
    );
  }

  Widget _buildProductListItem(Product product, ProductsViewModel vm) {
    return GestureDetector(
      onLongPress: () => _showEditDeleteDialog(product, vm),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Card(
          color: Colors.blue[200],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/150?text=Product"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rs.${product.price}/-",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => Get.toNamed("/addProduct", arguments: product),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => vm.deleteProduct(product),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDeleteDialog(Product product, ProductsViewModel vm) {
    Get.dialog(
      AlertDialog(
        title: const Text("Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text("Edit"),
              onTap: () {
                Get.back();
                Get.toNamed("/addProduct", arguments: product);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete"),
              onTap: () {
                Get.back();
                vm.deleteProduct(product);
              },
            ),
          ],
        ),
      ),
    );
  }
}


class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(ProductsViewModel());
  }
}