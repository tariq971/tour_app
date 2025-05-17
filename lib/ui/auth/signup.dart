import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/ui/auth/view_models/login_vm.dart';
import 'package:tour_app/ui/auth/view_models/signup_vm.dart';
import 'package:tour_app/ui/home/home.dart';

import '../../data/AuthRepository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SignUpViewModel signUpViewModel;
  // bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    signUpViewModel = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if (signUpViewModel.isUserLoggedIn()) {
        Get.offAllNamed("/home");
      }
    });
  }

  bool _obscureText = true;
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
                  "Login to continue",
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
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "password",
                    hintText: "Enter password",
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    if (value.length < 6) {
                      return "password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: " Confirm password",
                    hintText: "Enter password again",
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    if (value.length < 6) {
                      return "password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return signUpViewModel.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      signUpViewModel.signup(
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                      // if (_formKey.currentState!.validate()) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     // SnackBar(
                      //     //   // content: Text('Password: ${passwordController.text}'),
                      //     // ),
                      //   );
                    },
                    child: Text("SignUp"),

                    // child: Text("login"),
                  );
                }),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed("/login");
                  },
                  child: Text("Already have an account then! Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(SignUpViewModel());
  }

}
