import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/core/errors/app_exception.dart';
import 'package:news_reader/providers/repository_providers.dart';
import 'package:news_reader/providers/search_state.dart';
import 'package:news_reader/providers/service_providers.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  final Ref _ref;

  SearchNotifier(this._ref) : super(const SearchState.initial());

  Timer? _debounce;

  void search(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      state = const SearchState.initial();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query.trim());
    });
  }

  Future<void> _performSearch(String query) async {
    state = const SearchState.loading();

    try {
      final networkInfo = _ref.read(networkInfoProvider);
      final isConnected = await networkInfo.isConnected;

      final newsRepo = _ref.read(newsRepositoryProvider);

      if (!isConnected) {
        final cached = await newsRepo.getCachedSearchResults(query);
        if (cached != null && cached.isNotEmpty) {
          state = SearchState.loaded(
            articles: cached,
            query: query,
            currentPage: 1,
            hasReachedMax: true,
            isFromCache: true,
          );
        } else {
          state = const SearchState.error('No internet connection');
        }
        return;
      }

      final articles = await newsRepo.searchArticles(query: query);

      if (articles.isEmpty) {
        state = const SearchState.empty();
      } else {
        state = SearchState.loaded(
          articles: articles,
          query: query,
          currentPage: 1,
          hasReachedMax: false,
        );
      }
    } on AppException catch (e) {
      state = SearchState.error(e.message);
    } catch (e) {
      state = const SearchState.error('Failed to search articles');
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! SearchLoaded || currentState.hasReachedMax) return;

    try {
      final newsRepo = _ref.read(newsRepositoryProvider);
      final nextPage = currentState.currentPage + 1;
      final newArticles = await newsRepo.searchArticles(
        query: currentState.query,
        page: nextPage,
      );

      if (newArticles.isEmpty) {
        state = currentState.copyWith(hasReachedMax: true);
      } else {
        state = currentState.copyWith(
          articles: [...currentState.articles, ...newArticles],
          currentPage: nextPage,
          hasReachedMax: newArticles.length < 20,
        );
      }
    } catch (e) {
      // Keep existing data
    }
  }

  void clearSearch() {
    _debounce?.cancel();
    state = const SearchState.initial();
  }

  void updateArticleBookmark(String url, bool isBookmarked) {
    final currentState = state;
    if (currentState is! SearchLoaded) return;
    final updated = currentState.articles.map((a) {
      if (a.url == url) return a.copyWith(isBookmarked: isBookmarked);
      return a;
    }).toList();
    state = currentState.copyWith(articles: updated);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(ref);
});
