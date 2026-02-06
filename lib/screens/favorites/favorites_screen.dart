import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';
import '../../config/routes.dart';
import '../../providers/providers.dart';
import '../../widgets/common/wallpaper_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);
    final wallpapersState = ref.watch(wallpapersProvider);

    // Filter wallpapers to only show favorites
    final favoriteWallpapers = wallpapersState.wallpapers
        .where((w) => favoriteIds.contains(w.id))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Favorites', style: AppTypography.headlineMedium),
            Text(
              '${favoriteIds.length} wallpapers',
              style: AppTypography.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: favoriteIds.isEmpty
          ? _buildEmptyState(context, ref)
          : _buildGrid(context, ref, favoriteWallpapers, favoriteIds),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              size: 80,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.space6),
            Text(
              'No favorites yet',
              style: AppTypography.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              'Tap the heart icon on any wallpaper\nto save it here',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space8),
            ElevatedButton(
              onPressed: () {
                ref.read(selectedTabProvider.notifier).state = 1;
                context.go(AppRoutes.gallery);
              },
              child: const Text('Browse Wallpapers'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    WidgetRef ref,
    List wallpapers,
    Set<String> favoriteIds,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        left: AppSpacing.space2,
        right: AppSpacing.space2,
        top: AppSpacing.space2,
        bottom: 100,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.space2,
        mainAxisSpacing: AppSpacing.space2,
      ),
      itemCount: wallpapers.length,
      itemBuilder: (context, index) {
        final wallpaper = wallpapers[index];
        return WallpaperCard(
          wallpaper: wallpaper,
          isFavorite: true,
          onTap: () => context.push(AppRoutes.wallpaperPath(wallpaper.id)),
          onFavoriteToggle: () {
            ref.read(favoritesProvider.notifier).toggleFavorite(
                  wallpaper.id,
                  downloadUrl: wallpaper.downloadUrl,
                );
          },
        );
      },
    );
  }
}
