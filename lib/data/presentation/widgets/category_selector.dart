import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quote_controller.dart';

class CategorySelector extends StatelessWidget {
  final controller = Get.find<QuoteController>();

  final categories = const [
    'Motivation',
    'Love',
    'Success',
    'Wisdom',
    'Humor',
    'All'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((cat) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Obx(() => ChoiceChip(
              label: Text(cat),
              selected: controller.selectedCategory.value == cat,
              onSelected: (_) => controller.applyCategory(cat),
            )),
          );
        }).toList(),
      ),
    );
  }
}
