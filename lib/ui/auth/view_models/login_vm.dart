import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_app/data/AuthRepository.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  var isLoading = false.obs;
  Future<void> login(String email, String password) async {
    if (!email.contains("@")){
      Get.snackbar("Error", "Enter proper email");
      return;
    }
    try {
      await authRepository.login(email, password);
      //   success
      // Get.offAllNamed("/product");
      if(getLoggedInUser()?.email== "muhammadtariqkhan971@gmail.com") {
        Get.offAllNamed("/shop_home");
      } else {
        Get.offAllNamed("/customer_home");
      }
    } on FirebaseAuthException catch (e) {
      //   error
      Get.snackbar("Error", e.message ?? "Login failed");
    }

      isLoading.value = false;

  }
  bool isUserLoggedIn(){
    return authRepository.getLoggedInUser()!= null;
  }
  User? getLoggedInUser(){
    return authRepository.getLoggedInUser();
  }
}
