import 'package:flutter/material.dart';
import '../../../data/models/quote_model.dart';

class QuoteTemplateDark extends StatelessWidget {
  final QuoteModel quote;

  const QuoteTemplateDark({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            quote.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            quote.author,
            style: const TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
