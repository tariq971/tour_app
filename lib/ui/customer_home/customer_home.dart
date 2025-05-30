import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/data/AuthRepository.dart';
import 'package:tour_app/data/cart_repository.dart';
import 'package:tour_app/data/media_repo.dart';
import 'package:tour_app/data/product_repository.dart';
import 'package:tour_app/ui/cart/cart.dart';
import 'package:tour_app/ui/customer_home/customer_home_vm.dart';
import 'package:tour_app/ui/product/products.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int currentPage = 0;
  late CustomerHomeViewModel customerHomeViewModel;
  @override
  void initState() {
    super.initState();
    customerHomeViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: "Products",
            activeIcon: Icon(Icons.cake),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Shops",
            activeIcon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            icon: Obx(
              () => Badge(
                label: Text(
                  customerHomeViewModel.cartItemCount.value.toString(),
                ),

                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: "Carts",
            activeIcon: Obx(
              () => Badge(
                label: Text(
                  customerHomeViewModel.cartItemCount.value.toString(),
                ),
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
            activeIcon: Icon(Icons.shopping_bag),
          ),
        ],
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.blueAccent,
      ),
      body: getPage(currentPage),
    );
  }

  Widget getPage(int currentPage) {
    if (currentPage == 0) {
      ProductsBinding().dependencies();
      return ProductPage();
    }
    if (currentPage == 2) {
      CartBinding().dependencies();
      return CartPage();
    }
    return Placeholder();
  }
}

class CustomerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(CartItemRepository());
    Get.put(CustomerHomeViewModel());
    // Get.put(MediaRepository());
  }
}
