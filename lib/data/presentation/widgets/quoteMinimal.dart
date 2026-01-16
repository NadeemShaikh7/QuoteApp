import 'package:flutter/material.dart';
import '../../../data/models/quote_model.dart';

class QuoteTemplateMinimal extends StatelessWidget {
  final QuoteModel quote;

  const QuoteTemplateMinimal({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            quote.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '- ${quote.author}',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
