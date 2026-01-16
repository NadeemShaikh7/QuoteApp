import 'package:get/get.dart';

import '../../models/favorite_quote_model.dart';
import '../../repository/favorite_repository.dart';
import 'auth_controller.dart';

class FavoriteController extends GetxController {
  final FavoriteRepository _repo = FavoriteRepository();
  final AuthController _auth = Get.find();

  final favorites = <FavoriteQuote>[].obs;

  // ✅ ADD THIS
  final favoriteIds = <String>{}.obs;

  Future<void> loadFavorites() async {
    final userId = _auth.user.value!.id;
    favorites.value = await _repo.fetchFavorites(userId);

    // ✅ keep ids in sync
    favoriteIds.value =
        favorites.map((f) => f.quote.id).toSet();
  }

  Future<void> toggleFavorite(String quoteId, bool isFav) async {
    final userId = _auth.user.value!.id;

    if (isFav) {
      await _repo.removeFavorite(userId, quoteId);
      favoriteIds.remove(quoteId); // optimistic update
    } else {
      await _repo.addFavorite(userId, quoteId);
      favoriteIds.add(quoteId); // optimistic update
    }

    await loadFavorites();
  }

}
