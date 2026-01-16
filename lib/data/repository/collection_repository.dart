import '../../core/services/supabase_service.dart';
import '../models/collection_model.dart';
import '../models/quote_model.dart';

class CollectionRepository {
  final SupabaseService _service = SupabaseService.instance;

  Future<List<CollectionModel>> fetchCollections(String userId) async {
    final data = await _service.fetchCollections(userId: userId);
    return data.map((e) => CollectionModel.fromJson(e)).toList();
  }

  Future<void> createCollection(String userId, String name) {
    return _service.createCollection(userId: userId, name: name);
  }

  Future<List<QuoteModel>> fetchCollectionQuotes(
      String collectionId) async {
    final data =
    await _service.fetchCollectionQuotes(collectionId);
    return data
        .map((e) => QuoteModel.fromJson(e['quotes']))
        .toList();
  }

  Future<void> addQuote(
      String collectionId, String quoteId) {
    return _service.addQuoteToCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }

  Future<void> removeQuote(
      String collectionId, String quoteId) {
    return _service.removeQuoteFromCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }
}
