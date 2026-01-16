import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/collection_model.dart';
import '../../controllers/collection_controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../widgets/quote_card.dart';

class CollectionDetailScreen extends StatelessWidget {
  CollectionDetailScreen({super.key});

  final CollectionController controller =
  Get.put(CollectionController());
  final FavoriteController favoriteController =
  Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    final CollectionModel collection =
    Get.arguments as CollectionModel;

    controller.loadCollectionQuotes(collection.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
      ),
      body: Obx(() {
        if (controller.collectionQuotes.isEmpty) {
          return const Center(
            child: Text('No quotes in this collection'),
          );
        }

        return ListView.builder(
          itemCount: controller.collectionQuotes.length,
          itemBuilder: (_, index) {
            final quote = controller.collectionQuotes[index];

            return Dismissible(
              key: ValueKey(quote.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                controller.removeQuoteFromCollection(
                  collection.id,
                  quote.id,
                );
              },
              child: QuoteCard(quote: quote),
            );
          },
        );
      }),
    );
  }
}
