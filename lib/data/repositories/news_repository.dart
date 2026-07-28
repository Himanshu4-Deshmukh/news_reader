import 'package:news_reader/data/models/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    String country = 'us',
    String? category,
    int page = 1,
  });

  Future<List<Article>> searchArticles({
    required String query,
    int page = 1,
  });

  Future<List<Article>> getBookmarkedArticles();

  Future<void> bookmarkArticle(Article article);

  Future<void> removeBookmark(String articleUrl);

  Future<bool> isBookmarked(String articleUrl);
}
