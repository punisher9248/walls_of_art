import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';
import '../../config/routes.dart';
import '../../providers/providers.dart';
import '../../widgets/common/wallpaper_card.dart';
import '../../widgets/common/shimmer_loading.dart';
import '../../utils/responsive.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load wallpapers on first build
    Future.microtask(() {
      final state = ref.read(wallpapersProvider);
      if (state.wallpapers.isEmpty && !state.isLoading) {
        ref.read(wallpapersProvider.notifier).loadWallpapers();
      }
    });

    // Add scroll listener for infinite scroll
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(wallpapersProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallpapersState = ref.watch(wallpapersProvider);
    final favorites = ref.watch(favoritesProvider);
    final columns = Responsive.getGridColumns(context);
    final tagsAsync = ref.watch(tagsProvider);
    final currentTag = wallpapersState.currentTag;

    // Get the display name for the current tag
    String titleText = 'Gallery';
    if (currentTag != null) {
      final tags = tagsAsync.maybeWhen(
        data: (tags) => tags,
        orElse: () => null,
      );
      final tag = tags?.where((t) => t.slug == currentTag).firstOrNull;
      if (tag != null) {
        titleText = tag.name;
      } else {
        // Fallback: format the slug as a title
        titleText = currentTag.replaceAll('-', ' ').split(' ').map((word) {
          return word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : word;
        }).join(' ');
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: currentTag != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(wallpapersProvider.notifier).clearTag();
                },
              )
            : null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleText, style: AppTypography.headlineMedium),
            if (wallpapersState.pagination != null)
              Text(
                '${wallpapersState.pagination!.total} wallpapers',
                style: AppTypography.bodySmall,
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            onPressed: () => _showCategoriesBottomSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(wallpapersProvider.notifier).refresh(),
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        child: _buildBody(wallpapersState, favorites, columns),
      ),
    );
  }

  Widget _buildBody(WallpapersState state, Set<String> favorites, int columns) {
    // Show shimmer loading on initial load
    if (state.isLoading && state.wallpapers.isEmpty) {
      return WallpaperGridShimmer(
        crossAxisCount: columns,
        itemCount: columns * 4,
      );
    }

    if (state.error != null && state.wallpapers.isEmpty) {
      return _buildErrorState(state.error!);
    }

    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        left: Responsive.getHorizontalPadding(context),
        right: Responsive.getHorizontalPadding(context),
        top: Responsive.getHorizontalPadding(context),
        bottom: 100,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.space2,
        mainAxisSpacing: AppSpacing.space2,
      ),
      itemCount: state.wallpapers.length + (state.isLoadingMore ? columns : 0),
      itemBuilder: (context, index) {
        // Show shimmer for loading more items
        if (index >= state.wallpapers.length) {
          return const WallpaperCardShimmer();
        }

        final wallpaper = state.wallpapers[index];
        final isFavorite = favorites.contains(wallpaper.id);

        return WallpaperCard(
          wallpaper: wallpaper,
          isFavorite: isFavorite,
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

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 80,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.space6),
            Text(
              'Something went wrong',
              style: AppTypography.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              error,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space6),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(wallpapersProvider.notifier).loadWallpapers(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radius2xl),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) {
          final tagsAsync = ref.watch(tagsProvider);
          final currentTag = ref.watch(wallpapersProvider).currentTag;

          return Column(
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.all(AppSpacing.space3),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textMuted,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space4,
                  vertical: AppSpacing.space2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: AppTypography.headlineMedium),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border),
              // Tags list
              Expanded(
                child: tagsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  error: (error, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.error),
                        const SizedBox(height: AppSpacing.space2),
                        Text('Error: $error', style: AppTypography.bodyMedium),
                      ],
                    ),
                  ),
                  data: (tags) => ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 85, top: AppSpacing.space4, left: AppSpacing.space4, right: AppSpacing.space4),
                    itemCount: tags.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildCategoryTile(
                          context,
                          name: 'All Wallpapers',
                          count: null,
                          icon: Icons.apps,
                          isSelected: currentTag == null,
                          onTap: () {
                            ref.read(wallpapersProvider.notifier).clearTag();
                            Navigator.pop(context);
                          },
                        );
                      }
                      final tag = tags[index - 1];
                      return _buildCategoryTile(
                        context,
                        name: tag.name,
                        count: tag.count,
                        isSelected: currentTag == tag.slug,
                        onTap: () {
                          ref.read(wallpapersProvider.notifier).setTag(tag.slug);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context, {
    required String name,
    int? count,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space2),
      child: Material(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space4,
              vertical: AppSpacing.space3,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isSelected ? AppColors.primary : AppColors.textMuted,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.space3),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.titleMedium.copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      if (count != null)
                        Text(
                          '$count wallpapers',
                          style: AppTypography.bodySmall,
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
