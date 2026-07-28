import 'dart:convert';

import 'package:news_reader/core/constants/app_constants.dart';
import 'package:news_reader/core/errors/app_exception.dart';
import 'package:news_reader/data/datasources/api_service.dart';
import 'package:news_reader/data/datasources/local_storage_service.dart';
import 'package:news_reader/data/models/article.dart';
import 'package:news_reader/data/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiService _apiService;
  final LocalStorageService _localStorage;

  NewsRepositoryImpl({
    required ApiService apiService,
    required LocalStorageService localStorage,
  })  : _apiService = apiService,
        _localStorage = localStorage;

  @override
  Future<List<Article>> getTopHeadlines({
    String country = 'us',
    String? category,
    int page = 1,
  }) async {
    try {
      final data = await _apiService.getTopHeadlines(
        country: country,
        category: category,
        page: page,
      );

      final articlesJson = data['articles'] as List<dynamic>?;
      if (articlesJson == null || articlesJson.isEmpty) {
        return [];
      }

      final articles = articlesJson
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .toList();

      // Sync bookmarks
      final bookmarkedUrls = await _getBookmarkedUrls();
      return articles.map((a) {
        final isBookmarked = bookmarkedUrls.contains(a.url);
        return a.copyWith(isBookmarked: isBookmarked);
      }).toList();
    } on AppException {
      rethrow;
    } catch (e) {
      throw const InvalidResponseException();
    }
  }

  @override
  Future<List<Article>> searchArticles({
    required String query,
    int page = 1,
  }) async {
    try {
      final data = await _apiService.searchArticles(
        query: query,
        page: page,
      );

      final articlesJson = data['articles'] as List<dynamic>?;
      if (articlesJson == null || articlesJson.isEmpty) {
        return [];
      }

      final articles = articlesJson
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .toList();

      final bookmarkedUrls = await _getBookmarkedUrls();
      return articles.map((a) {
        final isBookmarked = bookmarkedUrls.contains(a.url);
        return a.copyWith(isBookmarked: isBookmarked);
      }).toList();
    } on AppException {
      rethrow;
    } catch (e) {
      throw const InvalidResponseException();
    }
  }

  @override
  Future<List<Article>> getBookmarkedArticles() async {
    try {
      final rawList = _localStorage.getList(AppConstants.bookmarksBox);
      return rawList
          .map((item) => Article.fromJson(jsonDecode(item as String)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> bookmarkArticle(Article article) async {
    try {
      final bookmarks = _localStorage.getList(AppConstants.bookmarksBox);
      final articleJson = jsonEncode(article.toJson());
      if (!bookmarks.contains(articleJson)) {
        bookmarks.add(articleJson);
        await _localStorage.saveList(AppConstants.bookmarksBox, bookmarks);
      }
    } catch (e) {
      throw const CacheException(message: 'Failed to bookmark article');
    }
  }

  @override
  Future<void> removeBookmark(String articleUrl) async {
    try {
      final bookmarks = _localStorage.getList(AppConstants.bookmarksBox);
      bookmarks.removeWhere((item) {
        final decoded = jsonDecode(item as String) as Map<String, dynamic>;
        return decoded['url'] == articleUrl;
      });
      await _localStorage.saveList(AppConstants.bookmarksBox, bookmarks);
    } catch (e) {
      throw const CacheException(message: 'Failed to remove bookmark');
    }
  }

  @override
  Future<bool> isBookmarked(String articleUrl) async {
    final urls = await _getBookmarkedUrls();
    return urls.contains(articleUrl);
  }

  Future<List<String>> _getBookmarkedUrls() async {
    final bookmarks = _localStorage.getList(AppConstants.bookmarksBox);
    return bookmarks.map((item) {
      final decoded = jsonDecode(item as String) as Map<String, dynamic>;
      return decoded['url'] as String? ?? '';
    }).toList();
  }
}
