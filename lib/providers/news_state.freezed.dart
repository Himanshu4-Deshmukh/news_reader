// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NewsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )
    loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsInitial value) initial,
    required TResult Function(NewsLoading value) loading,
    required TResult Function(NewsLoaded value) loaded,
    required TResult Function(NewsError value) error,
    required TResult Function(NewsEmpty value) empty,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsInitial value)? initial,
    TResult? Function(NewsLoading value)? loading,
    TResult? Function(NewsLoaded value)? loaded,
    TResult? Function(NewsError value)? error,
    TResult? Function(NewsEmpty value)? empty,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsInitial value)? initial,
    TResult Function(NewsLoading value)? loading,
    TResult Function(NewsLoaded value)? loaded,
    TResult Function(NewsError value)? error,
    TResult Function(NewsEmpty value)? empty,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsStateCopyWith<$Res> {
  factory $NewsStateCopyWith(NewsState value, $Res Function(NewsState) then) =
      _$NewsStateCopyWithImpl<$Res, NewsState>;
}

/// @nodoc
class _$NewsStateCopyWithImpl<$Res, $Val extends NewsState>
    implements $NewsStateCopyWith<$Res> {
  _$NewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NewsInitialImplCopyWith<$Res> {
  factory _$$NewsInitialImplCopyWith(
    _$NewsInitialImpl value,
    $Res Function(_$NewsInitialImpl) then,
  ) = __$$NewsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsInitialImplCopyWithImpl<$Res>
    extends _$NewsStateCopyWithImpl<$Res, _$NewsInitialImpl>
    implements _$$NewsInitialImplCopyWith<$Res> {
  __$$NewsInitialImplCopyWithImpl(
    _$NewsInitialImpl _value,
    $Res Function(_$NewsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NewsInitialImpl implements NewsInitial {
  const _$NewsInitialImpl();

  @override
  String toString() {
    return 'NewsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )
    loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsInitial value) initial,
    required TResult Function(NewsLoading value) loading,
    required TResult Function(NewsLoaded value) loaded,
    required TResult Function(NewsError value) error,
    required TResult Function(NewsEmpty value) empty,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsInitial value)? initial,
    TResult? Function(NewsLoading value)? loading,
    TResult? Function(NewsLoaded value)? loaded,
    TResult? Function(NewsError value)? error,
    TResult? Function(NewsEmpty value)? empty,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsInitial value)? initial,
    TResult Function(NewsLoading value)? loading,
    TResult Function(NewsLoaded value)? loaded,
    TResult Function(NewsError value)? error,
    TResult Function(NewsEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NewsInitial implements NewsState {
  const factory NewsInitial() = _$NewsInitialImpl;
}

/// @nodoc
abstract class _$$NewsLoadingImplCopyWith<$Res> {
  factory _$$NewsLoadingImplCopyWith(
    _$NewsLoadingImpl value,
    $Res Function(_$NewsLoadingImpl) then,
  ) = __$$NewsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsLoadingImplCopyWithImpl<$Res>
    extends _$NewsStateCopyWithImpl<$Res, _$NewsLoadingImpl>
    implements _$$NewsLoadingImplCopyWith<$Res> {
  __$$NewsLoadingImplCopyWithImpl(
    _$NewsLoadingImpl _value,
    $Res Function(_$NewsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NewsLoadingImpl implements NewsLoading {
  const _$NewsLoadingImpl();

  @override
  String toString() {
    return 'NewsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )
    loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsInitial value) initial,
    required TResult Function(NewsLoading value) loading,
    required TResult Function(NewsLoaded value) loaded,
    required TResult Function(NewsError value) error,
    required TResult Function(NewsEmpty value) empty,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsInitial value)? initial,
    TResult? Function(NewsLoading value)? loading,
    TResult? Function(NewsLoaded value)? loaded,
    TResult? Function(NewsError value)? error,
    TResult? Function(NewsEmpty value)? empty,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsInitial value)? initial,
    TResult Function(NewsLoading value)? loading,
    TResult Function(NewsLoaded value)? loaded,
    TResult Function(NewsError value)? error,
    TResult Function(NewsEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NewsLoading implements NewsState {
  const factory NewsLoading() = _$NewsLoadingImpl;
}

/// @nodoc
abstract class _$$NewsLoadedImplCopyWith<$Res> {
  factory _$$NewsLoadedImplCopyWith(
    _$NewsLoadedImpl value,
    $Res Function(_$NewsLoadedImpl) then,
  ) = __$$NewsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Article> articles,
    int currentPage,
    bool hasReachedMax,
    bool isFromCache,
  });
}

/// @nodoc
class __$$NewsLoadedImplCopyWithImpl<$Res>
    extends _$NewsStateCopyWithImpl<$Res, _$NewsLoadedImpl>
    implements _$$NewsLoadedImplCopyWith<$Res> {
  __$$NewsLoadedImplCopyWithImpl(
    _$NewsLoadedImpl _value,
    $Res Function(_$NewsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? currentPage = null,
    Object? hasReachedMax = null,
    Object? isFromCache = null,
  }) {
    return _then(
      _$NewsLoadedImpl(
        articles: null == articles
            ? _value._articles
            : articles // ignore: cast_nullable_to_non_nullable
                  as List<Article>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasReachedMax: null == hasReachedMax
            ? _value.hasReachedMax
            : hasReachedMax // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFromCache: null == isFromCache
            ? _value.isFromCache
            : isFromCache // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$NewsLoadedImpl implements NewsLoaded {
  const _$NewsLoadedImpl({
    required final List<Article> articles,
    required this.currentPage,
    required this.hasReachedMax,
    this.isFromCache = false,
  }) : _articles = articles;

  final List<Article> _articles;
  @override
  List<Article> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  final int currentPage;
  @override
  final bool hasReachedMax;
  @override
  @JsonKey()
  final bool isFromCache;

  @override
  String toString() {
    return 'NewsState.loaded(articles: $articles, currentPage: $currentPage, hasReachedMax: $hasReachedMax, isFromCache: $isFromCache)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsLoadedImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.isFromCache, isFromCache) ||
                other.isFromCache == isFromCache));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_articles),
    currentPage,
    hasReachedMax,
    isFromCache,
  );

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsLoadedImplCopyWith<_$NewsLoadedImpl> get copyWith =>
      __$$NewsLoadedImplCopyWithImpl<_$NewsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )
    loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return loaded(articles, currentPage, hasReachedMax, isFromCache);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return loaded?.call(articles, currentPage, hasReachedMax, isFromCache);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(articles, currentPage, hasReachedMax, isFromCache);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsInitial value) initial,
    required TResult Function(NewsLoading value) loading,
    required TResult Function(NewsLoaded value) loaded,
    required TResult Function(NewsError value) error,
    required TResult Function(NewsEmpty value) empty,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsInitial value)? initial,
    TResult? Function(NewsLoading value)? loading,
    TResult? Function(NewsLoaded value)? loaded,
    TResult? Function(NewsError value)? error,
    TResult? Function(NewsEmpty value)? empty,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsInitial value)? initial,
    TResult Function(NewsLoading value)? loading,
    TResult Function(NewsLoaded value)? loaded,
    TResult Function(NewsError value)? error,
    TResult Function(NewsEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class NewsLoaded implements NewsState {
  const factory NewsLoaded({
    required final List<Article> articles,
    required final int currentPage,
    required final bool hasReachedMax,
    final bool isFromCache,
  }) = _$NewsLoadedImpl;

  List<Article> get articles;
  int get currentPage;
  bool get hasReachedMax;
  bool get isFromCache;

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsLoadedImplCopyWith<_$NewsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsErrorImplCopyWith<$Res> {
  factory _$$NewsErrorImplCopyWith(
    _$NewsErrorImpl value,
    $Res Function(_$NewsErrorImpl) then,
  ) = __$$NewsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NewsErrorImplCopyWithImpl<$Res>
    extends _$NewsStateCopyWithImpl<$Res, _$NewsErrorImpl>
    implements _$$NewsErrorImplCopyWith<$Res> {
  __$$NewsErrorImplCopyWithImpl(
    _$NewsErrorImpl _value,
    $Res Function(_$NewsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NewsErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NewsErrorImpl implements NewsError {
  const _$NewsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NewsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsErrorImplCopyWith<_$NewsErrorImpl> get copyWith =>
      __$$NewsErrorImplCopyWithImpl<_$NewsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )
    loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsInitial value) initial,
    required TResult Function(NewsLoading value) loading,
    required TResult Function(NewsLoaded value) loaded,
    required TResult Function(NewsError value) error,
    required TResult Function(NewsEmpty value) empty,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsInitial value)? initial,
    TResult? Function(NewsLoading value)? loading,
    TResult? Function(NewsLoaded value)? loaded,
    TResult? Function(NewsError value)? error,
    TResult? Function(NewsEmpty value)? empty,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsInitial value)? initial,
    TResult Function(NewsLoading value)? loading,
    TResult Function(NewsLoaded value)? loaded,
    TResult Function(NewsError value)? error,
    TResult Function(NewsEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NewsError implements NewsState {
  const factory NewsError(final String message) = _$NewsErrorImpl;

  String get message;

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsErrorImplCopyWith<_$NewsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsEmptyImplCopyWith<$Res> {
  factory _$$NewsEmptyImplCopyWith(
    _$NewsEmptyImpl value,
    $Res Function(_$NewsEmptyImpl) then,
  ) = __$$NewsEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsEmptyImplCopyWithImpl<$Res>
    extends _$NewsStateCopyWithImpl<$Res, _$NewsEmptyImpl>
    implements _$$NewsEmptyImplCopyWith<$Res> {
  __$$NewsEmptyImplCopyWithImpl(
    _$NewsEmptyImpl _value,
    $Res Function(_$NewsEmptyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NewsEmptyImpl implements NewsEmpty {
  const _$NewsEmptyImpl();

  @override
  String toString() {
    return 'NewsState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewsEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )
    loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Article> articles,
      int currentPage,
      bool hasReachedMax,
      bool isFromCache,
    )?
    loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsInitial value) initial,
    required TResult Function(NewsLoading value) loading,
    required TResult Function(NewsLoaded value) loaded,
    required TResult Function(NewsError value) error,
    required TResult Function(NewsEmpty value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsInitial value)? initial,
    TResult? Function(NewsLoading value)? loading,
    TResult? Function(NewsLoaded value)? loaded,
    TResult? Function(NewsError value)? error,
    TResult? Function(NewsEmpty value)? empty,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsInitial value)? initial,
    TResult Function(NewsLoading value)? loading,
    TResult Function(NewsLoaded value)? loaded,
    TResult Function(NewsError value)? error,
    TResult Function(NewsEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class NewsEmpty implements NewsState {
  const factory NewsEmpty() = _$NewsEmptyImpl;
}
