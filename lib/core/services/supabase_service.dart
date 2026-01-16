import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._privateConstructor();
  static final SupabaseService instance =
  SupabaseService._privateConstructor();

  SupabaseClient get client => Supabase.instance.client;
// -----------------------------
// Quote of the Day
// -----------------------------
  Future<Map<String, dynamic>?> fetchQuoteOfTheDay() async {
    final today = DateTime.now();
    final daySeed =
        today.year * 10000 + today.month * 100 + today.day;

    final response = await client
        .from('quotes')
        .select()
        .order('id')
        .limit(1)
        .range(daySeed % 100, daySeed % 100);

    if (response.isEmpty) return null;
    return response.first;
  }

  Future<void> addToFavorites({
    required String userId,
    required String quoteId,
  }) async {
    await client.from('user_favorites').insert({
      'user_id': userId,
      'quote_id': quoteId,
    });
  }

  Future<void> removeFromFavorites({
    required String userId,
    required String quoteId,
  }) async {
    await client
        .from('user_favorites')
        .delete()
        .eq('user_id', userId)
        .eq('quote_id', quoteId);
  }

  Future<List<Map<String, dynamic>>> fetchFavorites({
    required String userId,
  }) async {
    final response = await client
        .from('user_favorites')
        .select('quote_id, quotes(*)')
        .eq('user_id', userId);

    return List<Map<String, dynamic>>.from(response);
  }

// -----------------------------
// Collections
// -----------------------------
  Future<List<Map<String, dynamic>>> fetchCollections({
    required String userId,
  }) async {
    final response = await client
        .from('collections')
        .select()
        .eq('user_id', userId);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> createCollection({
    required String userId,
    required String name,
  }) async {
    await client.from('collections').insert({
      'user_id': userId,
      'name': name,
    });
  }

  Future<void> addQuoteToCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    await client.from('collection_quotes').insert({
      'collection_id': collectionId,
      'quote_id': quoteId,
    });
  }

  Future<void> removeQuoteFromCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    await client
        .from('collection_quotes')
        .delete()
        .eq('collection_id', collectionId)
        .eq('quote_id', quoteId);
  }

  Future<List<Map<String, dynamic>>> fetchCollectionQuotes(
      String collectionId) async {
    final response = await client
        .from('collection_quotes')
        .select('quote_id, quotes(*)')
        .eq('collection_id', collectionId);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchQuotes({
    required int from,
    required int to,
    String? category,
    String? keyword,
    String? author,
  }) async {
    var query = client.from('quotes').select();

    if (category != null && category.isNotEmpty) {
      query = query.eq('category', category);
    }

    if (keyword != null && keyword.isNotEmpty) {
      query = query.ilike('text', '%$keyword%');
    }

    if (author != null && author.isNotEmpty) {
      query = query.ilike('author', '%$author%');
    }

    final response = await query.range(from, to);
    return List<Map<String, dynamic>>.from(response);
  }
}
