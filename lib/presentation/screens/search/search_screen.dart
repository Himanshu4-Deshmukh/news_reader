import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader/providers/search_provider.dart';
import 'package:news_reader/providers/search_state.dart';
import 'package:news_reader/providers/bookmark_provider.dart';
import 'package:news_reader/presentation/widgets/news_card.dart';
import 'package:news_reader/presentation/widgets/loading_shimmer.dart';
import 'package:news_reader/core/utils/responsive_utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final padding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(padding, 16, padding, 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(searchProvider.notifier).clearSearch();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {});
                    ref.read(searchProvider.notifier).search(value);
                  },
                  onSubmitted: (value) {
                    ref.read(searchProvider.notifier).search(value);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildBody(searchState),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(SearchState searchState) {
    final columns = ResponsiveUtils.gridColumns(context);
    final padding = ResponsiveUtils.horizontalPadding(context);

    return searchState.when(
      initial: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Search for news articles'),
          ],
        ),
      ),
      loading: () => const LoadingShimmer(),
      loaded: (articles, query, currentPage, hasReachedMax, isFromCache) {
        return Column(
          children: [
            if (isFromCache)
              MaterialBanner(
                padding: EdgeInsets.symmetric(horizontal: padding),
                content:
                    const Text('You are offline. Showing cached results.'),
                leading: const Icon(Icons.wifi_off),
                actions: [
                  TextButton(
                    onPressed: () =>
                        ref.read(searchProvider.notifier).search(query),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            Expanded(
              child: columns == 1
                  ? _buildListView(articles, hasReachedMax, padding)
                  : _buildGridView(
                      articles, hasReachedMax, columns, padding),
            ),
          ],
        );
      },
      error: (message) => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  final query = _searchController.text;
                  if (query.isNotEmpty) {
                    ref.read(searchProvider.notifier).search(query);
                  }
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      empty: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No results found'),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(
      List articles, bool hasReachedMax, double padding) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(padding),
      itemCount: articles.length + (hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index >= articles.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return NewsCard(
          article: articles[index],
          onTap: () {
            context.push('/article', extra: articles[index]);
          },
          onBookmark: () {
            ref.read(bookmarkProvider.notifier).toggleBookmark(
                  articles[index],
                );
          },
        );
      },
    );
  }

  Widget _buildGridView(
      List articles, bool hasReachedMax, int columns, double padding) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 16.0;
        final availableWidth =
            constraints.maxWidth - (padding * 2) - (spacing * (columns - 1));
        final cardWidth = availableWidth / columns;

        return SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(padding),
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              ...List.generate(
                articles.length,
                (index) => SizedBox(
                  width: cardWidth,
                  child: NewsCard(
                    article: articles[index],
                    onTap: () {
                      context.push('/article', extra: articles[index]);
                    },
                    onBookmark: () {
                      ref.read(bookmarkProvider.notifier).toggleBookmark(
                            articles[index],
                          );
                    },
                  ),
                ),
              ),
              if (!hasReachedMax)
                SizedBox(
                  width: cardWidth,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
