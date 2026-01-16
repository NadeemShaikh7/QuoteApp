import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController controller = Get.find();
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: emailCtrl),
            ElevatedButton(
              onPressed: () => controller.resetPassword(emailCtrl.text),
              child: const Text('Send Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}
