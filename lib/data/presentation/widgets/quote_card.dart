import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotevault/data/presentation/widgets/share_bottom_sheet.dart';

import '../../models/quote_model.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/collection_controller.dart';

class QuoteCard extends StatelessWidget {
  final QuoteModel quote;

  QuoteCard({super.key, required this.quote});

  final FavoriteController favoriteController =
  Get.find<FavoriteController>();
  final CollectionController collectionController =
  Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    // final bool isFavorite =
    // favoriteController.isFavorite(quote.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        // ---------- Quote Text ----------
        title: Text(
          quote.text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        // ---------- Author ----------
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            '- ${quote.author}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),

        // ---------- Actions ----------
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final isFavorite =
              favoriteController.favoriteIds.contains(quote.id);

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  favoriteController.toggleFavorite(
                    quote.id,
                    isFavorite,
                  );
                },
              );
            }),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Get.bottomSheet(
                  ShareQuoteSheet(quote: quote),
                  isScrollControlled: true,
                );
              },
            ),

            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'add_to_collection') {
                  _showAddToCollectionBottomSheet(context);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem<String>(
                  value: 'add_to_collection',
                  child: Text('Add to Collection'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddToCollectionBottomSheet(BuildContext context) {
    collectionController.loadCollections();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Obx(() {
          if (collectionController.collections.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text('No collections available'),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: collectionController.collections.length,
            itemBuilder: (_, index) {
              final collection =
              collectionController.collections[index];

              return ListTile(
                title: Text(collection.name),
                trailing: const Icon(Icons.add),
                onTap: () {
                  collectionController.addQuoteToCollection(
                    collection.id,
                    quote.id,
                  );
                  Get.back();
                  Get.snackbar(
                    'Added',
                    'Quote added to "${collection.name}"',
                  );
                },
              );
            },
          );
        }),
      ),
      isScrollControlled: true,
    );
  }
}
