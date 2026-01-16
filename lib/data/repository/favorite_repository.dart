import '../../core/services/supabase_service.dart';
import '../models/favorite_quote_model.dart';

class FavoriteRepository {
  final SupabaseService _service = SupabaseService.instance;

  Future<void> addFavorite(String userId, String quoteId) {
    return _service.addToFavorites(
      userId: userId,
      quoteId: quoteId,
    );
  }

  Future<void> removeFavorite(String userId, String quoteId) {
    return _service.removeFromFavorites(
      userId: userId,
      quoteId: quoteId,
    );
  }

  Future<List<FavoriteQuote>> fetchFavorites(String userId) async {
    final data = await _service.fetchFavorites(userId: userId);
    return data.map((e) => FavoriteQuote.fromJson(e)).toList();
  }
}
