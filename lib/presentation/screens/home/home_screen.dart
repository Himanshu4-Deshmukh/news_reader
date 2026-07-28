import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader/providers/auth_provider.dart';
import 'package:news_reader/providers/news_provider.dart';
import 'package:news_reader/providers/news_state.dart';
import 'package:news_reader/providers/bookmark_provider.dart';
import 'package:news_reader/providers/theme_provider.dart';
import 'package:news_reader/presentation/widgets/news_card.dart';
import 'package:news_reader/presentation/widgets/loading_shimmer.dart';
import 'package:news_reader/core/utils/responsive_utils.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedCategory;

  static const _categories = [
    'general',
    'business',
    'technology',
    'sports',
    'entertainment',
    'health',
    'science',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsProvider.notifier).fetchTopHeadlines(refresh: true);
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(newsProvider.notifier).loadMore();
    }
  }

  void _onCategorySelected(String? category) {
    setState(() => _selectedCategory = category);
    ref.read(newsProvider.notifier).fetchTopHeadlines(
          category: category,
          refresh: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsProvider);
    final themeMode = ref.watch(themeProvider);
    final isWide = ResponsiveUtils.isWide(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.brightness_auto,
            ),
            onSelected: (mode) {
              ref.read(themeProvider.notifier).setThemeMode(mode);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.light,
                child: ListTile(
                  leading: Icon(Icons.light_mode),
                  title: Text('Light Mode'),
                  dense: true,
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.dark,
                child: ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('Dark Mode'),
                  dense: true,
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.system,
                child: ListTile(
                  leading: Icon(Icons.brightness_auto),
                  title: Text('System'),
                  dense: true,
                ),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                ref.read(authProvider.notifier).logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  dense: true,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (isWide)
            _buildWrappedCategories()
          else
            _buildScrollableCategories(),
          Expanded(
            child: _buildBody(newsState),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableCategories() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return FilterChip(
            label: Text(category[0].toUpperCase() + category.substring(1)),
            selected: isSelected,
            onSelected: (_) {
              _onCategorySelected(isSelected ? null : category);
            },
          );
        },
      ),
    );
  }

  Widget _buildWrappedCategories() {
    final padding = ResponsiveUtils.horizontalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return FilterChip(
            label: Text(category[0].toUpperCase() + category.substring(1)),
            selected: isSelected,
            onSelected: (_) {
              _onCategorySelected(isSelected ? null : category);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBody(NewsState newsState) {
    final columns = ResponsiveUtils.gridColumns(context);
    final padding = ResponsiveUtils.horizontalPadding(context);

    return newsState.when(
      initial: () => const Center(child: Text('Pull to load news')),
      loading: () => const LoadingShimmer(),
      loaded: (articles, currentPage, hasReachedMax, isFromCache) {
        return Column(
          children: [
            if (isFromCache)
              MaterialBanner(
                padding: EdgeInsets.symmetric(horizontal: padding),
                content: const Text('You are offline. Showing cached articles.'),
                leading: const Icon(Icons.wifi_off),
                actions: [
                  TextButton(
                    onPressed: () =>
                        ref.read(newsProvider.notifier).refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(newsProvider.notifier).refresh(),
                child: columns == 1
                    ? _buildListView(articles, hasReachedMax, padding)
                    : _buildGridView(
                        articles, hasReachedMax, columns, padding),
              ),
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
                onPressed: () =>
                    ref.read(newsProvider.notifier).fetchTopHeadlines(refresh: true),
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
            Icon(Icons.article_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No articles found'),
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
