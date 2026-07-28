import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/data/models/article.dart';
import 'package:news_reader/providers/news_provider.dart';
import 'package:news_reader/providers/repository_providers.dart';
import 'package:news_reader/providers/search_provider.dart';

class BookmarkNotifier extends StateNotifier<AsyncValue<List<Article>>> {
  final Ref _ref;

  BookmarkNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(newsRepositoryProvider);
      final bookmarks = await repo.getBookmarkedArticles();
      state = AsyncValue.data(bookmarks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleBookmark(Article article) async {
    try {
      final repo = _ref.read(newsRepositoryProvider);
      final newBookmarked = !article.isBookmarked;
      if (article.isBookmarked) {
        await repo.removeBookmark(article.url ?? '');
      } else {
        await repo.bookmarkArticle(article);
      }
      _ref.read(newsProvider.notifier).updateArticleBookmark(
            article.url ?? '',
            newBookmarked,
          );
      _ref.read(searchProvider.notifier).updateArticleBookmark(
            article.url ?? '',
            newBookmarked,
          );
      await loadBookmarks();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, AsyncValue<List<Article>>>((ref) {
  return BookmarkNotifier(ref);
});
