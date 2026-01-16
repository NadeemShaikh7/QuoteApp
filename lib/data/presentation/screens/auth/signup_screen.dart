import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final AuthController controller = Get.find();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() => controller.isLoading.value
            ? Center(child: const CircularProgressIndicator())
            : Column(
          children: [
            TextField(controller: emailCtrl),
            TextField(controller: passwordCtrl, obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.signUp(
                emailCtrl.text,
                passwordCtrl.text,
              ),
              child: const Text('Create Account'),
            ),
          ],
        )),
      ),
    );
  }
}
