import 'package:get/get.dart';

import '../../models/quote_model.dart';
import '../../repository/quote_repository.dart';

class QuoteController extends GetxController {
  final QuoteRepository _repo = QuoteRepository();

  final quotes = <QuoteModel>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final hasMore = true.obs;

  int _page = 0;
  int _limit = 20;

  final selectedCategory = ''.obs;
  final searchKeyword = ''.obs;
  final searchAuthor = ''.obs;
  final dailyQuote = Rxn<QuoteModel>();
  @override
  void onInit() {
    fetchInitialQuotes();
    loadDailyQuote();
    super.onInit();
  }


  Future<void> loadDailyQuote() async {
    dailyQuote.value = await _repo.fetchQuoteOfTheDay();
  }


  Future<void> fetchInitialQuotes() async {
    _page = 0;
    hasMore(true);
    quotes.clear();
    await fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    if (!hasMore.value) return;

    try {
      _page == 0 ? isLoading(true) : isMoreLoading(true);
      if(selectedCategory == "All"){
        _limit = 100;
        selectedCategory("All");
        searchKeyword("");
        searchAuthor("");
      }
      final result = await _repo.fetchQuotes(
        page: _page,
        limit: _limit,
        category: selectedCategory == "All" ? "" : selectedCategory.value,
        keyword: searchKeyword.value,
        author: searchAuthor.value,
      );

      if (result.length < _limit) {
        hasMore(false);
      }

      quotes.addAll(result);
      _page++;
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }

  Future<void> refreshQuotes() async {
    await fetchInitialQuotes();
  }

  void applyCategory(String category) {
    selectedCategory(category);
    fetchInitialQuotes();
  }

  void applySearch({String? keyword, String? author}) {
    searchKeyword(keyword ?? '');
    searchAuthor(author ?? '');
    fetchInitialQuotes();
  }
}
