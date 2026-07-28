import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_reader/data/models/article.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.initial() = NewsInitial;
  const factory NewsState.loading() = NewsLoading;
  const factory NewsState.loaded({
    required List<Article> articles,
    required int currentPage,
    required bool hasReachedMax,
    @Default(false) bool isFromCache,
  }) = NewsLoaded;
  const factory NewsState.error(String message) = NewsError;
  const factory NewsState.empty() = NewsEmpty;
}
