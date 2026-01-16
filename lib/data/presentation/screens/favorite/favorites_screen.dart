import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favorite_controller.dart';
import '../../widgets/quote_card.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final controller = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    controller.loadFavorites();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }

        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (_, i) {
            return QuoteCard(
              quote: controller.favorites[i].quote,
            );
          },
        );
      }),
    );
  }
}
