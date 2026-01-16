import '../../core/services/supabase_service.dart';
import '../models/quote_model.dart';

class QuoteRepository {
  final SupabaseService _supabaseService =
      SupabaseService.instance;

  Future<QuoteModel?> fetchQuoteOfTheDay() async {
    final data =
    await _supabaseService.fetchQuoteOfTheDay();

    if (data == null) return null;
    return QuoteModel.fromJson(data);
  }


  Future<List<QuoteModel>> fetchQuotes({
    required int page,
    required int limit,
    String? category,
    String? keyword,
    String? author,
  }) async {
    final from = page * limit;
    final to = from + limit - 1;

    final data = await _supabaseService.fetchQuotes(
      from: from,
      to: to,
      category: category,
      keyword: keyword,
      author: author,
    );

    return data
        .map((json) => QuoteModel.fromJson(json))
        .toList();
  }
}
