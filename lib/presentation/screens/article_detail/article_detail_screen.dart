import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:news_reader/data/models/article.dart';
import 'package:news_reader/providers/bookmark_provider.dart';
import 'package:news_reader/core/utils/responsive_utils.dart';

class ArticleDetailScreen extends ConsumerWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat.yMMMMd().add_jm().format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWide = ResponsiveUtils.isWide(context);

    return Scaffold(
      body: isWide
          ? _buildWideLayout(context, ref)
          : _buildNarrowLayout(context, ref),
    );
  }

  Widget _buildNarrowLayout(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context, ref),
        SliverToBoxAdapter(
          child: _buildArticleContent(context),
        ),
      ],
    );
  }

  Widget _buildWideLayout(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, ref),
              SliverToBoxAdapter(
                child: _buildArticleContent(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: article.urlToImage != null
            ? CachedNetworkImage(
                imageUrl: article.urlToImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.image_not_supported, size: 64),
                ),
              )
            : Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.article, size: 64),
              ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            article.isBookmarked
                ? Icons.bookmark
                : Icons.bookmark_outline,
          ),
          onPressed: () {
            ref.read(bookmarkProvider.notifier).toggleBookmark(article);
          },
        ),
      ],
    );
  }

  Widget _buildArticleContent(BuildContext context) {
    final padding = ResponsiveUtils.horizontalPadding(context);
    final maxContentWidth = ResponsiveUtils.maxContentWidth(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.source?.name != null)
                Chip(
                  label: Text(article.source!.name!),
                  visualDensity: VisualDensity.compact,
                ),
              const SizedBox(height: 12),
              Text(
                article.title ?? 'No title',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (article.author != null) ...[
                    Icon(Icons.person_outline,
                        size: 16,
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        article.author!,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Icon(Icons.access_time,
                      size: 16,
                      color:
                          Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(article.publishedAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),
              if (article.description != null) ...[
                Text(
                  article.description!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 16),
              ],
              if (article.content != null)
                Text(
                  article.content!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
