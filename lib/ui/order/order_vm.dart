import 'package:get/get.dart';
import 'package:tour_app/data/order_repository.dart';
import 'package:tour_app/model/Order.dart';
import '../../../data/AuthRepository.dart';
import '../../data/product_repository.dart';
import '../../utils/Functions.dart';

class OrderViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  // CartItemRepository cartItemRepository=Get.find();
  OrderRepository orderRepository = Get.find();

  var isLoading = false.obs;
  var orderItems = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllOrderItems();
  }

  Future<void> loadAllOrderItems() async {
    if (Functions.isShop(authRepository.getLoggedInUser())) {
      orderRepository
          .loadOrderOfShop(authRepository.getLoggedInUser()!.uid)
          .listen((data) {
            orderItems.value = data;
          });
    }
    else {
      orderRepository
          .loadOrderOfUser(authRepository.getLoggedInUser()!.uid)
          .listen((data) {
            orderItems.value = data;
          });
    }
  }
}
