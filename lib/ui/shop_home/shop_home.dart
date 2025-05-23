import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_app/ui/product/products.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}
class _ShopHomePageState extends State<ShopHomePage> {
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: "Products",
            activeIcon: Icon(Icons.cake,  ),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Order",
            activeIcon: Icon(Icons.shopping_bag, ),
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart),
          //   label: "Carts",
          //   activeIcon: Icon(Icons.shopping_cart, color: Colors.red),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_bag),
          //   label: "Orders",
          //   activeIcon: Icon(Icons.shopping_bag, color: Colors.red),
          // ),
        ],
        onTap: (value){
setState(() {
  currentPage=value;
});
        },
        currentIndex: currentPage,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.blueGrey,
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
    return Placeholder();
  }
}

