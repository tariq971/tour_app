import 'package:get/get.dart';
import 'package:tour_app/data/AuthRepository.dart';
import 'package:tour_app/data/product_repository.dart';
import 'package:tour_app/model/Product.dart';

class ProductsViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  var isSaving = false.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllProducts();
  }

  void loadAllProducts() {
    productsRepository.loadAllProducts().listen((data) {
      products.value = data;
    });
  }
  void deleteProduct(Product product){
    productsRepository.deleteProduct(product);
  }
}
