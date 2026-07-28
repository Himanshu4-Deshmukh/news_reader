import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/core/errors/app_exception.dart';
import 'package:news_reader/providers/news_state.dart';
import 'package:news_reader/providers/repository_providers.dart';
import 'package:news_reader/providers/service_providers.dart';

class NewsNotifier extends StateNotifier<NewsState> {
  final Ref _ref;

  NewsNotifier(this._ref) : super(const NewsState.initial());

  String? _currentCategory;

  Future<void> fetchTopHeadlines({String? category, bool refresh = false}) async {
    _currentCategory = category;

    if (refresh) {
      state = const NewsState.loading();
    }

    try {
      final networkInfo = _ref.read(networkInfoProvider);
      final isConnected = await networkInfo.isConnected;

      final newsRepo = _ref.read(newsRepositoryProvider);

      if (!isConnected) {
        // Try loading from cache
        final cached = await newsRepo.getCachedHeadlines(category: category);
        if (cached != null && cached.isNotEmpty) {
          state = NewsState.loaded(
            articles: cached,
            currentPage: 1,
            hasReachedMax: true,
            isFromCache: true,
          );
        } else {
          state = const NewsState.error('No internet connection');
        }
        return;
      }

      final articles = await newsRepo.getTopHeadlines(
        category: category,
        page: 1,
      );

      if (articles.isEmpty) {
        state = const NewsState.empty();
      } else {
        state = NewsState.loaded(
          articles: articles,
          currentPage: 1,
          hasReachedMax: false,
        );
      }
    } on AppException catch (e) {
      if (state is NewsLoaded) {
        return;
      }
      state = NewsState.error(e.message);
    } catch (e) {
      state = const NewsState.error('Failed to fetch news');
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! NewsLoaded || currentState.hasReachedMax) return;

    try {
      final newsRepo = _ref.read(newsRepositoryProvider);
      final nextPage = currentState.currentPage + 1;
      final newArticles = await newsRepo.getTopHeadlines(
        category: _currentCategory,
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
    } on AppException {
      // Keep existing data on load-more failure
    } catch (_) {
      // Keep existing data
    }
  }

  Future<void> refresh() async {
    await fetchTopHeadlines(category: _currentCategory, refresh: true);
  }
}

final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  return NewsNotifier(ref);
});
