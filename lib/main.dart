
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'core/services/notification_service.dart';
import 'data/presentation/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

  await Supabase.initialize(
    url: 'https://cweqnhedsutdslaaluok.supabase.co',
    anonKey: 'sb_publishable_VdS9VUMXKJwIcoSuf7FsCg_iA-vPuAu',
  );
  await NotificationService.init();
  runApp(const QuoteVaultApp());
}