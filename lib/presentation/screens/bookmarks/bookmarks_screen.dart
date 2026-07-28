import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader/providers/bookmark_provider.dart';
import 'package:news_reader/presentation/widgets/news_card.dart';
import 'package:news_reader/core/utils/responsive_utils.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksState = ref.watch(bookmarkProvider);
    final padding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: bookmarksState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(error.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () =>
                      ref.read(bookmarkProvider.notifier).loadBookmarks(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (bookmarks) {
          if (bookmarks.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No bookmarks yet'),
                    SizedBox(height: 8),
                    Text('Tap the bookmark icon on articles to save them'),
                  ],
                ),
              ),
            );
          }

          final columns = ResponsiveUtils.gridColumns(context);

          if (columns == 1) {
            return ListView.builder(
              padding: EdgeInsets.all(padding),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final article = bookmarks[index];
                return NewsCard(
                  article: article,
                  onTap: () {
                    context.push('/article', extra: article);
                  },
                  onBookmark: () {
                    ref.read(bookmarkProvider.notifier).toggleBookmark(article);
                  },
                );
              },
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 16.0;
              final availableWidth = constraints.maxWidth -
                  (padding * 2) -
                  (spacing * (columns - 1));
              final cardWidth = availableWidth / columns;

              return SingleChildScrollView(
                padding: EdgeInsets.all(padding),
                child: Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: List.generate(
                    bookmarks.length,
                    (index) {
                      final article = bookmarks[index];
                      return SizedBox(
                        width: cardWidth,
                        child: NewsCard(
                          article: article,
                          onTap: () {
                            context.push('/article', extra: article);
                          },
                          onBookmark: () {
                            ref
                                .read(bookmarkProvider.notifier)
                                .toggleBookmark(article);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
