import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotevault/data/presentation/widgets/quoteDark.dart';
import 'package:quotevault/data/presentation/widgets/quoteMinimal.dart';
import 'package:quotevault/data/presentation/widgets/quote_template.dart';

import '../../../core/services/share_service.dart';
import '../../../core/utils/image_utils.dart';
import '../../models/quote_model.dart';

class ShareQuoteSheet extends StatefulWidget {
  final QuoteModel quote;

  const ShareQuoteSheet({super.key, required this.quote});

  @override
  State<ShareQuoteSheet> createState() => _ShareQuoteSheetState();
}

class _ShareQuoteSheetState extends State<ShareQuoteSheet> {
  int selectedTemplate = 0;
  final GlobalKey previewKey = GlobalKey();

  Widget _buildTemplate() {
    switch (selectedTemplate) {
      case 1:
        return QuoteTemplateGradient(quote: widget.quote);
      case 2:
        return QuoteTemplateDark(quote: widget.quote);
      default:
        return QuoteTemplateMinimal(quote: widget.quote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: previewKey,
            child: _buildTemplate(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return IconButton(
                icon: Icon(
                  Icons.circle,
                  color:
                  selectedTemplate == index ? Colors.blue : Colors.grey,
                ),
                onPressed: () =>
                    setState(() => selectedTemplate = index),
              );
            }),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.image),
            label: const Text('Share Image'),
            onPressed: () async {
              final file = await ImageUtils.captureWidget(previewKey);
              await ShareService.shareImage(file);
            },
          ),
          TextButton(
            onPressed: () {
              ShareService.shareText(
                quote: widget.quote.text,
                author: widget.quote.author,
              );
            },
            child: const Text('Share as Text'),
          ),
        ],
      ),
    );
  }
}
