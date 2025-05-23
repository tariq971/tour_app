import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/ui/auth/signup.dart';
import 'package:tour_app/ui/auth/view_models/login_vm.dart';
import 'package:tour_app/ui/auth/view_models/reset_password_vm.dart';
// import 'package:tour_app/ui/auth/view_models/signup_dependency.dart';
import 'package:tour_app/ui/customer_home/customer_home.dart';

import '../../data/AuthRepository.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController emailController ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ResetPasswordViewModel resetViewModel;
  // bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController =TextEditingController(text: Get.arguments);
     resetViewModel = Get.find();
  }

  // bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  "Reset Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: " Enter Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                ),
                // SizedBox(height: 10,),

                Obx(() {
                  return resetViewModel.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      resetViewModel.reset(
                        emailController.text,

                      );
                      // if (_formKey.currentState!.validate()) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     // SnackBar(
                      //     //   // content: Text('Password: ${passwordController.text}'),
                      //     // ),
                      //   );
                    },
                    child: Text("Reset"),

                    // child: Text("login"),
                  );
                }),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("back"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ResetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ResetPasswordViewModel());
  }

}
