import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';
import '../../config/routes.dart';
import '../../providers/providers.dart';
import '../../widgets/common/wallpaper_card.dart';

class TagScreen extends ConsumerStatefulWidget {
  final String tagSlug;
  final String? tagName;

  const TagScreen({
    super.key,
    required this.tagSlug,
    this.tagName,
  });

  @override
  ConsumerState<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends ConsumerState<TagScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load wallpapers for this tag
    Future.microtask(() {
      ref.read(wallpapersProvider.notifier).loadWallpapers(
            tag: widget.tagSlug,
            refresh: true,
          );
    });

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

    final displayName = widget.tagName ??
        widget.tagSlug.replaceAll('-', ' ').split(' ').map((word) {
          return word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : word;
        }).join(' ');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(displayName, style: AppTypography.headlineMedium),
            if (wallpapersState.pagination != null)
              Text(
                '${wallpapersState.pagination!.total} wallpapers',
                style: AppTypography.bodySmall,
              ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(wallpapersProvider.notifier).refresh(),
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        child: _buildBody(wallpapersState, favorites),
      ),
    );
  }

  Widget _buildBody(WallpapersState state, Set<String> favorites) {
    if (state.isLoading && state.wallpapers.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state.error != null && state.wallpapers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Something went wrong',
              style: AppTypography.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              state.error!,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space6),
            ElevatedButton(
              onPressed: () => ref.read(wallpapersProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.wallpapers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_not_supported_outlined,
              size: 64,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'No wallpapers found',
              style: AppTypography.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              'There are no wallpapers in this category yet',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.space2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: AppSpacing.space2,
        mainAxisSpacing: AppSpacing.space2,
      ),
      itemCount: state.wallpapers.length + (state.isLoadingMore ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= state.wallpapers.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.space4),
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            ),
          );
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
}
