import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/ui/auth/login.dart';
import 'package:tour_app/ui/auth/signup.dart';
import 'package:tour_app/firebase_options.dart';
import 'package:tour_app/ui/auth/forget_password.dart';
import 'package:tour_app/ui/customer_home/customer_home.dart';
import 'package:tour_app/ui/product/add_product.dart';
import 'package:tour_app/ui/product/products.dart';
import 'package:tour_app/ui/shop_home/shop_home.dart';

import 'firebase_options.dart';
// import 'package:tour_app/ui/auth/view_models/login_dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: [
        GetPage(name: "/login", page: ()=>LoginPage(),binding: LoginBinding()),
        GetPage(name: "/signup", page: ()=>SignUpPage(),binding: SignUpBinding()),
        GetPage(name: "/forget_password", page: ()=>ResetPasswordPage(),binding: ResetPasswordBinding()),
        GetPage(name: "/customer_home", page: ()=>CustomerHomePage(),),
        GetPage(name: "/shop_home", page: ()=>ShopHomePage(),),
        GetPage(name: "/products", page: ()=>ProductPage(),binding: ProductsBinding()),
        GetPage(name: "/addProduct", page: ()=>AddProduct(), binding: AddProductBinding()),
      ],

      initialRoute: "/login",
    );
  }
}


