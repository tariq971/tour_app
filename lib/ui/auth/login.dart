import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_app/ui/auth/view_models/login_vm.dart';
import 'package:tour_app/utils/Functions.dart';
import '../../data/AuthRepository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginViewModel loginViewModel;
  // bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    loginViewModel = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loginViewModel.isUserLoggedIn()) {
        if(Functions.isShop(loginViewModel.getLoggedInUser())) {
          Get.offAllNamed("/shop_home");
        } else {
          Get.offAllNamed("/customer_home");
        }
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
                Obx(() {
                  return loginViewModel.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                          loginViewModel.login(
                            emailController.text,
                            passwordController.text,
                          );
                          // if (_formKey.currentState!.validate()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     // SnackBar(
                          //     //   // content: Text('Password: ${passwordController.text}'),
                          //     // ),
                          //   );
                        },
                        child: Text("Login"),

                        // child: Text("login"),
                      );
                }),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed("/signup");
                  },
                  child: Text("Don't have an account? SignUp"),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed("/forget_password",arguments: emailController.text);
                  },
                  child: Text("Forget password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(LoginViewModel());
  }

}
