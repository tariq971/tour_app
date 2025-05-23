import 'package:flutter/material.dart';
import 'package:tour_app/ui/cart/cart.dart';
import 'package:tour_app/ui/product/products.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}
class _CustomerHomePageState extends State<CustomerHomePage> {
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: "Products",
            activeIcon: Icon(Icons.cake, ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Shops",
            activeIcon: Icon(Icons.shopping_bag, ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Carts",
            activeIcon: Icon(Icons.shopping_cart, ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
            activeIcon: Icon(Icons.shopping_bag,),
          ),
        ],
        onTap: (value){
setState(() {
  currentPage=value;
});
        },
        currentIndex: currentPage,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.blueAccent,
      ),
      body: getPage(currentPage) ,

    );
  }
  Widget getPage(int currentPage){
    if(currentPage==0)
      {
        ProductsBinding().dependencies();
        return ProductPage();
      }
    if(currentPage==2)
      {
        CartBinding().dependencies();
        return CartPage();
      }
    return Placeholder();
  }
}

