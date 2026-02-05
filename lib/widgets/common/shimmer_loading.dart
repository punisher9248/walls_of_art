import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/colors.dart';
import '../../config/spacing.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget child;

  const ShimmerLoading({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surfaceHover,
      child: child,
    );
  }
}

class WallpaperCardShimmer extends StatelessWidget {
  const WallpaperCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
    );
  }
}

class WallpaperGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;

  const WallpaperGridShimmer({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.space2),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.space2,
        mainAxisSpacing: AppSpacing.space2,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const WallpaperCardShimmer(),
    );
  }
}

class TagChipShimmer extends StatelessWidget {
  final double width;

  const TagChipShimmer({super.key, this.width = 80});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        width: width,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
      ),
    );
  }
}

class TagsRowShimmer extends StatelessWidget {
  const TagsRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.space2),
            child: TagChipShimmer(width: 60.0 + (index * 10)),
          );
        },
      ),
    );
  }
}

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            color: AppColors.surface,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID badge
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                ),
                const SizedBox(height: AppSpacing.space3),
                // Title
                Container(
                  width: double.infinity,
                  height: 28,
                  color: AppColors.surface,
                ),
                const SizedBox(height: AppSpacing.space2),
                Container(
                  width: 200,
                  height: 28,
                  color: AppColors.surface,
                ),
                const SizedBox(height: AppSpacing.space3),
                // Metadata
                Container(
                  width: 250,
                  height: 16,
                  color: AppColors.surface,
                ),
                const SizedBox(height: AppSpacing.space6),
                // Button
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
