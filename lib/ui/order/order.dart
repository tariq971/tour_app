import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/data/order_repository.dart';
import 'package:tour_app/model/Order.dart';
import '../../data/AuthRepository.dart';
import '../../data/order_repository.dart';
import '../../data/product_repository.dart';
import 'order_vm.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderViewModel orderViewModel;

  @override
  void initState() {
    super.initState();
    orderViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orderViewModel.orderItems.length,
                itemBuilder: (context, index) {
                  Order order =
                      orderViewModel.orderItems[index];
                  return ListTile(
                    onLongPress: () {
                      Get.dialog(
                        AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // TextButton(
                              //   child: const Text('Delete'),
                              //   onPressed: () {
                              //     Get.back();
                              //     orderViewModel.deleteOrderItem(
                              //       orderItemWithProduct.orderItem,
                              //     );
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: Text(order.customerName),

                    trailing: Column(
                      children: [
                        Text(order.status??"pending"),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        
                        Text( order.orderItems.fold("",(previousValue,element)=>previousValue+element.name+" , ",)),
                        Text("Total. ${order.getGrandTotal()}"),

                        
                        
                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        );
      }),
    );
  }
}

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(OrderRepository());
    Get.put(OrderViewModel());
  }
}
