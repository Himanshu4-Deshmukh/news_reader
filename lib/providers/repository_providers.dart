import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/data/repositories/auth_repository.dart';
import 'package:news_reader/data/repositories/news_repository.dart';
import 'package:news_reader/data/repositories/news_repository_impl.dart';
import 'package:news_reader/providers/service_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    localStorage: ref.read(localStorageServiceProvider),
  );
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(
    apiService: ref.read(apiServiceProvider),
    localStorage: ref.read(localStorageServiceProvider),
  );
});
