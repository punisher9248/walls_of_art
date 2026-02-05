import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/colors.dart';
import '../../../config/typography.dart';
import '../../../config/spacing.dart';
import '../../../models/models.dart';
import '../../../utils/image_proxy.dart';

class TagGallerySection extends StatelessWidget {
  final String tagName;
  final String tagSlug;
  final List<Wallpaper> wallpapers;
  final VoidCallback onSeeAll;
  final void Function(String id) onWallpaperTap;
  final void Function(Wallpaper) onFavoriteToggle;
  final Set<String> favorites;

  const TagGallerySection({
    super.key,
    required this.tagName,
    required this.tagSlug,
    required this.wallpapers,
    required this.onSeeAll,
    required this.onWallpaperTap,
    required this.onFavoriteToggle,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    if (wallpapers.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with gradient accent
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space4,
              vertical: AppSpacing.space3,
            ),
            child: Row(
              children: [
                // Accent bar
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tagName,
                        style: AppTypography.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Curated collection',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                // See All button
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onSeeAll,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space4,
                          vertical: AppSpacing.space2,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space1),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primary,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Featured Gallery Grid - 6 images in creative layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            child: _FeaturedGalleryGrid(
              wallpapers: wallpapers.take(6).toList(),
              favorites: favorites,
              onWallpaperTap: onWallpaperTap,
              onFavoriteToggle: onFavoriteToggle,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedGalleryGrid extends StatelessWidget {
  final List<Wallpaper> wallpapers;
  final Set<String> favorites;
  final void Function(String id) onWallpaperTap;
  final void Function(Wallpaper) onFavoriteToggle;

  const _FeaturedGalleryGrid({
    required this.wallpapers,
    required this.favorites,
    required this.onWallpaperTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Layout: 2 rows of 3 images each
    return Column(
      children: [
        // First row
        Row(
          children: [
            for (int i = 0; i < 3 && i < wallpapers.length; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: i < 2 ? AppSpacing.space2 : 0,
                  ),
                  child: _GalleryThumbnail(
                    wallpaper: wallpapers[i],
                    isFavorite: favorites.contains(wallpapers[i].id),
                    onTap: () => onWallpaperTap(wallpapers[i].id),
                    onFavoriteToggle: () => onFavoriteToggle(wallpapers[i]),
                    aspectRatio: 1.0,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.space2),
        // Second row
        Row(
          children: [
            for (int i = 3; i < 6 && i < wallpapers.length; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: i < 5 ? AppSpacing.space2 : 0,
                  ),
                  child: _GalleryThumbnail(
                    wallpaper: wallpapers[i],
                    isFavorite: favorites.contains(wallpapers[i].id),
                    onTap: () => onWallpaperTap(wallpapers[i].id),
                    onFavoriteToggle: () => onFavoriteToggle(wallpapers[i]),
                    aspectRatio: 1.0,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _GalleryThumbnail extends StatelessWidget {
  final Wallpaper wallpaper;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final double aspectRatio;

  const _GalleryThumbnail({
    required this.wallpaper,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
    this.aspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image with loading shimmer
              CachedNetworkImage(
                imageUrl: ImageProxy.getUrl(wallpaper.thumbnailUrl),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.surface,
                        AppColors.surface.withValues(alpha: 0.5),
                        AppColors.surface,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surface,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.textMuted,
                    size: 32,
                  ),
                ),
              ),

              // Hover gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.4),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),

              // Favorite button
              Positioned(
                top: AppSpacing.space2,
                right: AppSpacing.space2,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.background.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorite ? AppColors.secondary : AppColors.textPrimary,
                      size: 16,
                    ),
                  ),
                ),
              ),

              // Resolution badge
              if (wallpaper.resolution != null)
                Positioned(
                  bottom: AppSpacing.space2,
                  left: AppSpacing.space2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      wallpaper.resolution!.toUpperCase(),
                      style: AppTypography.dataSmall.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
