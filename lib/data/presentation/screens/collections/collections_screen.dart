import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/collection_controller.dart';

class CollectionsScreen extends StatelessWidget {
  CollectionsScreen({super.key});

  final controller = Get.put(CollectionController());

  @override
  Widget build(BuildContext context) {
    controller.loadCollections();

    return Scaffold(
      appBar: AppBar(title: const Text('Collections')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.collections.isEmpty) {
          return const Center(child: Text('No collections'));
        }

        return ListView.builder(
          itemCount: controller.collections.length,
          itemBuilder: (_, i) {
            final c = controller.collections[i];
            return ListTile(
              title: Text(c.name),
              onTap: () =>
                  Get.toNamed('/collection-detail', arguments: c),
            );
          },
        );
      }),
    );
  }

  void _showCreateDialog() {
    final textCtrl = TextEditingController();
    Get.dialog(AlertDialog(
      title: const Text('New Collection'),
      content: TextField(controller: textCtrl),
      actions: [
        ElevatedButton(
          onPressed: () {
            controller.createCollection(textCtrl.text);
            Get.back();
          },
          child: const Text('Create'),
        ),
      ],
    ));
  }
}
