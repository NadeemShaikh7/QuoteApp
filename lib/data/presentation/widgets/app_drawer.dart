import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = authController.user.value;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Text(
                user?.email[0].toUpperCase() ?? '?',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            accountName: Text(user?.name ?? 'User'),
            accountEmail: Text(user?.email ?? ''),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Get.toNamed('/profile');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Get.toNamed('/favorites');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.collections),
            title: const Text('Collections'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Get.toNamed('/collections');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Get.toNamed('/settings');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
