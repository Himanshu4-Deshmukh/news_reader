import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader/data/models/article.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.loaded({
    required List<Article> articles,
    required String query,
    required int currentPage,
    required bool hasReachedMax,
    @Default(false) bool isFromCache,
  }) = SearchLoaded;
  const factory SearchState.error(String message) = SearchError;
  const factory SearchState.empty() = SearchEmpty;
}
