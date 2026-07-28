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
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
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
          ),
          Expanded(
            child: _buildBody(newsState),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(NewsState newsState) {
    return newsState.when(
      initial: () => const Center(child: Text('Pull to load news')),
      loading: () => const LoadingShimmer(),
      loaded: (articles, currentPage, hasReachedMax) {
        return RefreshIndicator(
          onRefresh: () => ref.read(newsProvider.notifier).refresh(),
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
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
          ),
        );
      },
      error: (message) => Center(
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
}
