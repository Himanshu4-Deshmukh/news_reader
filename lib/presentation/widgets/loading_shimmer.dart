import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news_reader/core/utils/responsive_utils.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final columns = ResponsiveUtils.gridColumns(context);
    final isWide = ResponsiveUtils.isWide(context);

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: columns == 1
          ? _buildListShimmer(context)
          : _buildGridShimmer(context, columns, isWide),
    );
  }

  Widget _buildListShimmer(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => _shimmerCard(context, isHorizontal: false),
    );
  }

  Widget _buildGridShimmer(BuildContext context, int columns, bool isWide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = ResponsiveUtils.horizontalPadding(context);
        final spacing = 16.0;
        final availableWidth = constraints.maxWidth - (padding * 2) - (spacing * (columns - 1));
        final cardWidth = availableWidth / columns;

        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(
              10,
              (index) => SizedBox(
                width: cardWidth,
                child: _shimmerCard(context, isHorizontal: isWide),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _shimmerCard(BuildContext context, {required bool isHorizontal}) {
    if (isHorizontal) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 14,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 16,
            width: 120,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Container(
            height: 14,
            width: double.infinity,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Container(
            height: 14,
            width: 200,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
