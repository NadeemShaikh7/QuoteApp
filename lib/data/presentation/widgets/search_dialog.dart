import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quote_controller.dart';

class SearchDialog extends StatelessWidget {
  final keywordCtrl = TextEditingController();
  final authorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuoteController>();

    return AlertDialog(
      title: const Text('Search Quotes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: keywordCtrl,
            decoration: const InputDecoration(labelText: 'Keyword'),
          ),
          TextField(
            controller: authorCtrl,
            decoration: const InputDecoration(labelText: 'Author'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.applySearch(
              keyword: keywordCtrl.text,
              author: authorCtrl.text,
            );
            Get.back();
          },
          child: const Text('Search'),
        ),
      ],
    );
  }
}
