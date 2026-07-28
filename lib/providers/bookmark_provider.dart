import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/data/models/article.dart';
import 'package:news_reader/providers/repository_providers.dart';

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
      if (article.isBookmarked) {
        await repo.removeBookmark(article.url ?? '');
      } else {
        await repo.bookmarkArticle(article);
      }
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
