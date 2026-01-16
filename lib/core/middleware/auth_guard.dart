import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/presentation/controllers/auth_controller.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    return auth.isLoggedIn ? null : const RouteSettings(name: '/login');
  }
}
