import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/colors.dart';
import '../../config/spacing.dart';
import '../../config/routes.dart';
import '../../providers/providers.dart';
import 'widgets/hero_section.dart';
import 'widgets/trending_tags.dart';
import 'widgets/favorites_preview.dart';
import 'widgets/tag_gallery_section.dart';
import 'widgets/all_categories_grid.dart';
import 'widgets/app_footer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load wallpapers if not already loaded
    Future.microtask(() {
      final state = ref.read(wallpapersProvider);
      if (state.wallpapers.isEmpty && !state.isLoading) {
        ref.read(wallpapersProvider.notifier).loadWallpapers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallpapersState = ref.watch(wallpapersProvider);
    final tagsAsync = ref.watch(tagsProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(wallpapersProvider.notifier).refresh();
          await ref.read(tagsNotifierProvider.notifier).refresh();
        },
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        child: CustomScrollView(
          slivers: [
            // Hero Section with image carousel
            SliverToBoxAdapter(
              child: HeroSection(),
            ),

            // Trending Tags
            SliverToBoxAdapter(
              child: tagsAsync.when(
                loading: () => const SizedBox(height: 60),
                error: (_, __) => const SizedBox.shrink(),
                data: (tags) => TrendingTags(
                  tags: tags.take(10).toList(),
                  onTagTap: (tag) => context.push(
                    '${AppRoutes.tagPath(tag.slug)}?name=${tag.name}',
                  ),
                ),
              ),
            ),

            // Favorites Preview (if user has favorites)
            if (favorites.isNotEmpty)
              SliverToBoxAdapter(
                child: FavoritesPreview(
                  wallpapers: wallpapersState.wallpapers
                      .where((w) => favorites.contains(w.id))
                      .take(6)
                      .toList(),
                  totalCount: favorites.length,
                  onSeeAll: () {
                    ref.read(selectedTabProvider.notifier).state = 2;
                    context.go(AppRoutes.favorites);
                  },
                  onWallpaperTap: (id) => context.push(AppRoutes.wallpaperPath(id)),
                ),
              ),

            // Tag Gallery Sections - Featured Categories
            SliverToBoxAdapter(
              child: tagsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (tags) {
                  // Get first 6 tags with wallpapers for featured galleries
                  final displayTags = tags.take(6).toList();
                  return Column(
                    children: displayTags.map((tag) {
                      final tagWallpapers = wallpapersState.wallpapers
                          .where((w) => w.tags.any((t) => t.slug == tag.slug))
                          .take(6)
                          .toList();

                      if (tagWallpapers.isEmpty) return const SizedBox.shrink();

                      return TagGallerySection(
                        tagName: tag.name,
                        tagSlug: tag.slug,
                        wallpapers: tagWallpapers,
                        onSeeAll: () => context.push(
                          '${AppRoutes.tagPath(tag.slug)}?name=${tag.name}',
                        ),
                        onWallpaperTap: (id) => context.push(
                          AppRoutes.wallpaperPath(id),
                        ),
                        onFavoriteToggle: (wallpaper) {
                          ref.read(favoritesProvider.notifier).toggleFavorite(
                            wallpaper.id,
                            downloadUrl: wallpaper.downloadUrl,
                          );
                        },
                        favorites: favorites,
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            // All Categories Grid
            SliverToBoxAdapter(
              child: tagsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (tags) => AllCategoriesGrid(
                  tags: tags,
                  onTagTap: (tag) => context.push(
                    '${AppRoutes.tagPath(tag.slug)}?name=${tag.name}',
                  ),
                ),
              ),
            ),

            // Footer
            SliverToBoxAdapter(
              child: AppFooter(
                onPrivacyTap: () => context.push(AppRoutes.privacy),
                onTermsTap: () => context.push(AppRoutes.terms),
                onSettingsTap: () => context.push(AppRoutes.settings),
              ),
            ),

            // Bottom padding for navigation bar
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.space20),
            ),
          ],
        ),
      ),
    );
  }
}
