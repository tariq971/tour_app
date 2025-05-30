import 'package:get/get.dart';
import 'package:tour_app/data/AuthRepository.dart';
import 'package:tour_app/data/cart_repository.dart';
import 'package:tour_app/data/media_repo.dart';
import 'package:tour_app/data/product_repository.dart';

class CustomerHomeViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  // MediaRepository mediaRepository=Get.find();
  ProductsRepository productsRepository=Get.find();

  CartItemRepository cartItemRepository= Get.find();
var cartItemCount=0.obs;
  @override
  void onInit() {
    super.onInit();
    loadCartCount();
  }
  void loadCartCount() {
    cartItemRepository.loadCartItemOfUser(authRepository.getLoggedInUser()!.uid).listen((data) {
      cartItemCount.value=data.length;
    });
  }
  
}


