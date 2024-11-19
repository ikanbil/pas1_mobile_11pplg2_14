// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/widget/my_text.dart';
import 'package:pas1_mobile_10pplg2_14/widget/my_textfield.dart';

import '../api_login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 300),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
              child: MyTextField(
                hintText: 'Username',
                controller: usernameController,
                icon: Icons.person_outline,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
              child: MyTextField(
                hintText: 'Password',
                isPassword: true,
                controller: passwordController,
                icon: Icons.lock_outline,
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.fromLTRB(70, 0, 70, 12),
              child: Obx(
                () => ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () async {
                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: MyText(
                                    hintText: "Nama dan password harus diisi!",
                                    fontSize: 16,
                                    colors: Colors.white,
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            } else {
                              await controller.login(
                                usernameController.text,
                                passwordController.text,
                              );
                              final message = controller.loginStatus.value;
                              final isSuccess = message == "Login success";
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: MyText(
                                    hintText: message,
                                    fontSize: 16,
                                    colors: Colors.white,
                                  ),
                                  backgroundColor:
                                      isSuccess ? Colors.green : Colors.red,
                                ),
                              );
                              if (isSuccess) {
                                Get.offNamed('/dashboard');
                              }
                            }
                          },
                  child:
                      controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : MyText(
                            hintText: "Login",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            colors: Colors.blueAccent,
                          ),
                ),
              ),
            ),

            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  hintText: "Don't have an account? ",
                  fontSize: 16,
                  colors: Colors.white,
                ),
                GestureDetector(
                  onTap: () {},
                  child: MyText(
                    hintText: 'Sign Up',
                    fontSize: 16,
                    colors: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.tiktok, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.facebook, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
