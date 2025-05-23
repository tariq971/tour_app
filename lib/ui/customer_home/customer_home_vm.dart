import 'package:get/get.dart';
import 'package:tour_app/data/AuthRepository.dart';
import 'package:tour_app/data/cart_repository.dart';

class CustomerHomeViewModel extends GetxController {
  AuthRepository authRepository = Get.find();

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


