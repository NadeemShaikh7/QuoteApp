import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/notification_service.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  final emailCtrl = TextEditingController(text: "nads0796@gmail.com");
  final passwordCtrl = TextEditingController(text: "Nads@071996");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () => controller.login(
                emailCtrl.text,
                passwordCtrl.text,
              ),
              child: const Text('Login'),
            )),
            TextButton(
              onPressed: () => Get.toNamed('/forgot'),
              child: const Text('Forgot Password?'),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () => Get.toNamed('/signup'),
              child: const Text('Create Account'),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                NotificationService.testNotification();
              },
              child: const Text('Test Notification'),
            ),

          ],
        ),
      ),
    );
  }
}
