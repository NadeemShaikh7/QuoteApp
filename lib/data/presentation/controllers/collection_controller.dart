import 'package:get/get.dart';
import '../../models/collection_model.dart';
import '../../models/quote_model.dart';
import '../../repository/collection_repository.dart';
import '../controllers/auth_controller.dart';

class CollectionController extends GetxController {
  final CollectionRepository _repo = CollectionRepository();
  final AuthController _auth = Get.find();

  final collections = <CollectionModel>[].obs;
  final collectionQuotes = <QuoteModel>[].obs;

  Future<void> loadCollections() async {
    collections.value =
    await _repo.fetchCollections(_auth.user.value!.id);
  }

  Future<void> createCollection(String name) async {
    await _repo.createCollection(_auth.user.value!.id, name);
    await loadCollections();
  }

  Future<void> loadCollectionQuotes(String collectionId) async {
    collectionQuotes.value =
    await _repo.fetchCollectionQuotes(collectionId);
  }

  Future<void> addQuoteToCollection(
      String collectionId, String quoteId) async {
    await _repo.addQuote(collectionId, quoteId);
    await loadCollectionQuotes(collectionId);
  }

  Future<void> removeQuoteFromCollection(
      String collectionId, String quoteId) async {
    await _repo.removeQuote(collectionId, quoteId);
    await loadCollectionQuotes(collectionId);
  }
}
