import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/data/media_repo.dart';
import 'package:tour_app/data/product_repository.dart';
import 'package:tour_app/model/Product.dart';
import 'package:tour_app/ui/product/view_models/add_product_vm.dart';
import '../../data/AuthRepository.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  late AddProductViewModel addProductViewModel;
  Product? product;

  @override
  void initState() {
    super.initState();
    addProductViewModel = Get.find();
    product = Get.arguments;
    if (product != null) {
      nameController = TextEditingController(text: product?.name);
      priceController = TextEditingController(text: product?.price.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  "Add Product",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                Obx(()=> addProductViewModel.image.value==null? Icon(Icons.image,size: 80,):
                Image.file(File(addProductViewModel.image.value!.path),width: 150,height: 150),
                ),
                ElevatedButton(onPressed: (){
                  addProductViewModel.pickImage();
                }, child: Text("Pick image")),
                
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Product name",
                    hintText: " Enter Product name",
                    prefixIcon: Icon(Icons.abc),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                ),
                // SizedBox(height: 10,),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Price of product ",
                    hintText: "Enter price for product",
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                ),
                Obx(() {
                  return addProductViewModel.isSaving.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                            addProductViewModel.addProduct(
                              nameController.text,
                              priceController.text, product,
                            );
                        },
                        child: Text("Saving"),
                      );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(AddProductViewModel());
    Get.put(MediaRepository());
  }
}
