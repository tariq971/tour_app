import 'package:tour_app/data/AuthRepository.dart';
import 'package:get/get.dart';
import 'package:tour_app/data/product_repository.dart';
import 'package:tour_app/model/Product.dart';

class AddProductViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  var isSaving = false.obs;

  Future<void> addProduct(String name, String price, Product? product) async {
    if (name.isEmpty) {
      Get.snackbar("Error", "Enter proper Name");
      return;
    }
    if (price.isEmpty) {
      Get.snackbar("Error", "Enter proper Price");
      return;
    }
    isSaving.value = true;
    if (product == null) {
      Product product = Product(
        "",
        authRepository.getLoggedInUser()?.uid ?? "",
        name,
        int.parse(price),
      );
      try {
        await productsRepository.addProduct(product);
        Get.back(result: true);
      } catch (e) {
        Get.snackbar("Error", "An error occurred ${e.toString()}");
      }
    } else {
      product.name = name;
      product.price = int.parse(price);
      try {
        await productsRepository.addProduct(product);
        Get.back(result: true);
      } catch (e) {
        Get.snackbar("Error", "An error occurred ${e.toString()}");
      }
    }
    isSaving.value = false;
  }
  pickImage(){

  }
}
