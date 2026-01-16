import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/collection_controller.dart';
import '../../controllers/quote_controller.dart';
import '../../widgets/daily_quote_card.dart';
import '../../widgets/quote_card.dart';
import '../../widgets/loading_view.dart';
import '../../widgets/empty_view.dart';
import '../../widgets/category_selector.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final QuoteController controller = Get.put(QuoteController());
  final CollectionController collectionController =
  Get.put(CollectionController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchQuotes();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuoteVault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.dialog(SearchDialog());
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear filters',
            onPressed: () {
              controller.applySearch(keyword: '', author: '');
              controller.applyCategory('');
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Obx(() {
            final quote = controller.dailyQuote.value;
            if (quote == null) return const SizedBox.shrink();
            return DailyQuoteCard(quote: quote);
          }),

          SizedBox(height: 20,),
          CategorySelector(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.quotes.isEmpty) {
                return const LoadingView();
              }

              if (controller.quotes.isEmpty) {
                return const EmptyView(
                  message: 'No quotes found',
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshQuotes,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.quotes.length +
                      (controller.isMoreLoading.value ? 1 : 0),
                  itemBuilder: (_, index) {
                    if (index == controller.quotes.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return QuoteCard(
                      quote: controller.quotes[index],
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
