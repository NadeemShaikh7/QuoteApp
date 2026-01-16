
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotevault/data/presentation/screens/auth/forget_password_screen.dart';
import 'package:quotevault/data/presentation/screens/auth/signup_screen.dart';
import 'package:quotevault/data/presentation/screens/profile/profile_screen.dart';
import 'package:quotevault/data/presentation/screens/settings/settings_screen.dart';

import 'core/constants/app_themes.dart';
import 'core/middleware/auth_guard.dart';
import 'data/presentation/controllers/setting_controller.dart';
import 'data/presentation/screens/auth/login_screen.dart';
import 'data/presentation/screens/collections/collections_details_screen.dart';
import 'data/presentation/screens/collections/collections_screen.dart';
import 'data/presentation/screens/favorite/favorites_screen.dart';
import 'data/presentation/screens/home/home_screen.dart';

class QuoteVaultApp extends StatelessWidget {
  const QuoteVaultApp({super.key});


  @override
  Widget build(BuildContext context) {
    final SettingsController settings =
    Get.put(SettingsController(), permanent: true);

    return Obx(() => GetMaterialApp(
      title: 'QuoteVault',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(
        isDark: false,
        accent: Color(
          settings.accentColors[
          settings.accentIndex.value],
        ),
        fontScale: settings.fontScale.value,
      ),
      darkTheme: buildTheme(
        isDark: true,
        accent: Color(
          settings.accentColors[
          settings.accentIndex.value],
        ),
        fontScale: settings.fontScale.value,
      ),
      initialRoute: "/login",
      themeMode: settings.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      getPages: [
        // ---------------- Auth ----------------
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupScreen(),
        ),
        GetPage(
          name: '/forgot',
          page: () => ForgotPasswordScreen(),
        ),

        // ---------------- Home ----------------
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          middlewares: [AuthGuard()],
        ),

        // ---------------- Profile ----------------
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
          middlewares: [AuthGuard()],
        ),

        // ---------------- Favorites ----------------
        GetPage(
          name: '/favorites',
          page: () => FavoritesScreen(),
          middlewares: [AuthGuard()],
        ),

        // ---------------- Collections ----------------
        GetPage(
          name: '/collections',
          page: () => CollectionsScreen(),
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: '/collection-detail',
          page: () => CollectionDetailScreen(),
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsScreen(),
          middlewares: [AuthGuard()],
        ),
      ],
    ));
  }
}
