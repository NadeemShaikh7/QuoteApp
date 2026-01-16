import 'quote_model.dart';

class FavoriteQuote {
  final QuoteModel quote;

  FavoriteQuote({required this.quote});

  factory FavoriteQuote.fromJson(Map<String, dynamic> json) {
    return FavoriteQuote(
      quote: QuoteModel.fromJson(json['quotes']),
    );
  }
}
