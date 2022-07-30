import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplebankingapp/src/controllers/auth.controller.dart';
import 'package:simplebankingapp/src/utils/custom_snackbar.dart';
import 'package:simplebankingapp/src/views/widgets/button.dart';
import 'package:simplebankingapp/src/views/widgets/input.dart';
import 'package:simplebankingapp/src/views/widgets/text.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthController authController = Get.put(AuthController());
  final TextEditingController? _phoneController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();

  //Since both the phone number and password are used for the login and registration, i decided to just use one screen for both the login and signup
  bool isLogin = true;

  @override
  void initState() {
    // ApiService().getData();
    super.initState();
  }

  loginUser() async {
    if (_phoneController!.text.isEmpty || _passwordController!.text.isEmpty) {
      customSnackBar("Please enter all the fields");
    } else {
      authController.login(_phoneController!.text, _passwordController!.text);
    }
  }

  registerUser() async {
    if (_phoneController!.text.isEmpty || _passwordController!.text.isEmpty) {
      customSnackBar("Please enter all the fields");
    } else {
      authController.signup(_phoneController!.text, _passwordController!.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 50),
              CustomText(
                text: isLogin ? "Login" : "Register",
                fontSize: 35,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: isLogin ? "Welcome Back" : "Create your account",
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomInput(
                label: "Phone Number",
                hint: "Enter your phone number",
                controller: _phoneController,
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: "Password",
                hint: "Enter your password",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: authController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF2c2c54)),
                      ))
                    : isLogin
                        ? CustomButton(
                            text: "Login",
                            onPressed: () {
                              loginUser();
                            },
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 3,
                          )
                        : CustomButton(
                            text: "Register",
                            onPressed: () {
                              registerUser();
                            },
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 3,
                          ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: CustomText(
                  text: !isLogin
                      ? "Already have an account? Login"
                      : "Don't have an account? Create one",
                  fontSize: 16,
                  color: const Color(0xFF40407a),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
