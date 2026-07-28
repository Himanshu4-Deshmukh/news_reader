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

      // Cache articles for offline use (only page 1)
      if (page == 1) {
        await _saveHeadlinesToCache(articles, category);
      }

      final bookmarkedUrls = await _getBookmarkedUrls();
      return articles.map((a) {
        final isBookmarked = bookmarkedUrls.contains(a.url);
        return a.copyWith(isBookmarked: isBookmarked);
      }).toList();
    } on AppException {
      // Try loading from cache before rethrowing
      final cached = await _getCachedHeadlines(category: category);
      if (cached != null && cached.isNotEmpty) return cached;
      rethrow;
    } catch (e) {
      final cached = await _getCachedHeadlines(category: category);
      if (cached != null && cached.isNotEmpty) return cached;
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

      // Cache search results for offline use (only page 1)
      if (page == 1) {
        await _saveSearchToCache(query, articles);
      }

      final bookmarkedUrls = await _getBookmarkedUrls();
      return articles.map((a) {
        final isBookmarked = bookmarkedUrls.contains(a.url);
        return a.copyWith(isBookmarked: isBookmarked);
      }).toList();
    } on AppException {
      final cached = await _getCachedSearchResults(query);
      if (cached != null && cached.isNotEmpty) return cached;
      rethrow;
    } catch (e) {
      final cached = await _getCachedSearchResults(query);
      if (cached != null && cached.isNotEmpty) return cached;
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

  Future<void> _saveHeadlinesToCache(List<Article> articles, String? category) async {
    try {
      final key = AppConstants.cachedHeadlines;
      final raw = _localStorage.get(key, defaultValue: <String, dynamic>{});
      final cache = Map<String, dynamic>.from(raw as Map);

      final serialized = articles.map((a) => jsonEncode(a.toJson())).toList();
      cache[category ?? ''] = serialized;
      await _localStorage.save(key, cache);
    } catch (_) {}
  }

  Future<List<Article>?> _getCachedHeadlines({String? category}) async {
    try {
      final key = AppConstants.cachedHeadlines;
      final raw = _localStorage.get(key);
      if (raw == null) return null;

      final cache = Map<String, dynamic>.from(raw as Map);
      final rawArticles = cache[category ?? ''] as List<dynamic>?;
      if (rawArticles == null || rawArticles.isEmpty) return null;

      final articles = rawArticles.map((item) {
        return Article.fromJson(jsonDecode(item as String));
      }).toList();

      final bookmarkedUrls = await _getBookmarkedUrls();
      return articles.map((a) {
        final isBookmarked = bookmarkedUrls.contains(a.url);
        return a.copyWith(isBookmarked: isBookmarked);
      }).toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> _saveSearchToCache(String query, List<Article> articles) async {
    try {
      final key = AppConstants.cachedSearch;
      final raw = _localStorage.get(key, defaultValue: <String, dynamic>{});
      final cache = Map<String, dynamic>.from(raw as Map);

      final serialized = articles.map((a) => jsonEncode(a.toJson())).toList();
      cache[query] = serialized;
      await _localStorage.save(key, cache);
    } catch (_) {}
  }

  Future<List<Article>?> _getCachedSearchResults(String query) async {
    try {
      final key = AppConstants.cachedSearch;
      final raw = _localStorage.get(key);
      if (raw == null) return null;

      final cache = Map<String, dynamic>.from(raw as Map);
      final rawArticles = cache[query] as List<dynamic>?;
      if (rawArticles == null || rawArticles.isEmpty) return null;

      final articles = rawArticles.map((item) {
        return Article.fromJson(jsonDecode(item as String));
      }).toList();

      final bookmarkedUrls = await _getBookmarkedUrls();
      return articles.map((a) {
        final isBookmarked = bookmarkedUrls.contains(a.url);
        return a.copyWith(isBookmarked: isBookmarked);
      }).toList();
    } catch (_) {
      return null;
    }
  }

  // Public cache methods for external use
  @override
  Future<void> cacheHeadlines({String? category}) async {
    // Re-fetch and cache (used externally to refresh cache)
    try {
      final data = await _apiService.getTopHeadlines(category: category, page: 1);
      final articlesJson = data['articles'] as List<dynamic>?;
      if (articlesJson == null || articlesJson.isEmpty) return;
      final articles = articlesJson
          .map((j) => Article.fromJson(j as Map<String, dynamic>))
          .toList();
      await _saveHeadlinesToCache(articles, category);
    } catch (_) {}
  }

  @override
  Future<List<Article>?> getCachedHeadlines({String? category}) async {
    return _getCachedHeadlines(category: category);
  }

  @override
  Future<void> cacheSearchResults(String query, List<Article> articles) async {
    await _saveSearchToCache(query, articles);
  }

  @override
  Future<List<Article>?> getCachedSearchResults(String query) async {
    return _getCachedSearchResults(query);
  }
}
