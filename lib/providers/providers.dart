import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../services/services.dart';
import '../models/models.dart';

// ============ Service Providers ============

final apiServiceProvider = Provider<ApiService>((ref) {
  final service = ApiService();
  ref.onDispose(() => service.dispose());
  return service;
});

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService();
});

final wallpaperServiceProvider = Provider<WallpaperService>((ref) {
  return WallpaperService();
});

final cacheServiceProvider = Provider<CacheService>((ref) {
  final service = CacheService();
  ref.onDispose(() => service.dispose());
  return service;
});

final downloadServiceProvider = Provider<DownloadService>((ref) {
  return DownloadService();
});

// ============ Tags Provider ============

class TagsState {
  final List<Tag> tags;
  final bool isLoading;
  final bool isLoaded;
  final String? error;

  const TagsState({
    this.tags = const [],
    this.isLoading = false,
    this.isLoaded = false,
    this.error,
  });

  TagsState copyWith({
    List<Tag>? tags,
    bool? isLoading,
    bool? isLoaded,
    String? error,
    bool clearError = false,
  }) {
    return TagsState(
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class TagsNotifier extends StateNotifier<TagsState> {
  final ApiService _apiService;

  TagsNotifier(this._apiService) : super(const TagsState());

  Future<void> loadTags({bool forceRefresh = false}) async {
    // Skip if already loaded and not forcing refresh
    if (state.isLoaded && !forceRefresh) return;

    // Skip if already loading
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final tags = await _apiService.getTags();
      state = state.copyWith(
        tags: tags,
        isLoading: false,
        isLoaded: true,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load categories',
      );
    }
  }

  Future<void> refresh() async {
    await loadTags(forceRefresh: true);
  }
}

final tagsNotifierProvider =
    StateNotifierProvider<TagsNotifier, TagsState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TagsNotifier(apiService);
});

// Convenience provider that returns AsyncValue for backwards compatibility
final tagsProvider = Provider<AsyncValue<List<Tag>>>((ref) {
  final state = ref.watch(tagsNotifierProvider);

  // Auto-load tags on first access
  if (!state.isLoaded && !state.isLoading && state.error == null) {
    Future.microtask(() {
      ref.read(tagsNotifierProvider.notifier).loadTags();
    });
  }

  if (state.isLoading && state.tags.isEmpty) {
    return const AsyncValue.loading();
  }
  if (state.error != null && state.tags.isEmpty) {
    return AsyncValue.error(state.error!, StackTrace.current);
  }
  return AsyncValue.data(state.tags);
});

// ============ Favorites Provider ============

class FavoritesNotifier extends StateNotifier<Set<String>> {
  final FavoritesService _favoritesService;
  final CacheService _cacheService;

  FavoritesNotifier(this._favoritesService, this._cacheService) : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _favoritesService.getFavorites();
    state = favorites.toSet();
  }

  bool isFavorite(String id) => state.contains(id);

  Future<void> toggleFavorite(String id, {String? downloadUrl}) async {
    final newState = Set<String>.from(state);
    if (newState.contains(id)) {
      newState.remove(id);
      await _favoritesService.removeFavorite(id);
      if (downloadUrl != null) {
        await _cacheService.removeFromCache(downloadUrl);
      }
    } else {
      newState.add(id);
      await _favoritesService.addFavorite(id);
      if (downloadUrl != null) {
        await _cacheService.cacheFullImage(downloadUrl);
      }
    }
    state = newState;
  }

  Future<void> addFavorite(String id, {String? downloadUrl}) async {
    if (!state.contains(id)) {
      final newState = Set<String>.from(state)..add(id);
      state = newState;
      await _favoritesService.addFavorite(id);
      if (downloadUrl != null) {
        await _cacheService.cacheFullImage(downloadUrl);
      }
    }
  }

  Future<void> removeFavorite(String id) async {
    if (state.contains(id)) {
      final newState = Set<String>.from(state)..remove(id);
      state = newState;
      await _favoritesService.removeFavorite(id);
    }
  }

  Future<void> clearAll() async {
    state = {};
    await _favoritesService.clearAll();
    await _cacheService.clearFullImages();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  final favoritesService = ref.watch(favoritesServiceProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return FavoritesNotifier(favoritesService, cacheService);
});

// ============ Wallpapers Provider ============

class WallpapersState {
  final List<Wallpaper> wallpapers;
  final Pagination? pagination;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String? currentTag;
  final String sortBy;

  const WallpapersState({
    this.wallpapers = const [],
    this.pagination,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentTag,
    this.sortBy = 'newest',
  });

  WallpapersState copyWith({
    List<Wallpaper>? wallpapers,
    Pagination? pagination,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? currentTag,
    String? sortBy,
    bool clearError = false,
  }) {
    return WallpapersState(
      wallpapers: wallpapers ?? this.wallpapers,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : (error ?? this.error),
      currentTag: currentTag ?? this.currentTag,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  bool get hasMore => pagination?.hasNextPage ?? false;
  int get totalCount => pagination?.total ?? wallpapers.length;
}

class WallpapersNotifier extends StateNotifier<WallpapersState> {
  final ApiService _apiService;

  WallpapersNotifier(this._apiService) : super(const WallpapersState());

  Future<void> loadWallpapers({String? tag, String? sortBy, bool refresh = false}) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      clearError: true,
      currentTag: tag,
      sortBy: sortBy ?? state.sortBy,
      wallpapers: refresh ? [] : state.wallpapers,
    );

    try {
      final response = await _apiService.getWallpapers(
        page: 1,
        tag: tag,
        sort: sortBy ?? state.sortBy,
      );
      state = state.copyWith(
        wallpapers: response.wallpapers,
        pagination: response.pagination,
        isLoading: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final response = await _apiService.getWallpapers(
        page: state.pagination!.nextPage,
        tag: state.currentTag,
        sort: state.sortBy,
      );
      state = state.copyWith(
        wallpapers: [...state.wallpapers, ...response.wallpapers],
        pagination: response.pagination,
        isLoadingMore: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.message,
      );
    }
  }

  Future<void> refresh() async {
    await loadWallpapers(
      tag: state.currentTag,
      sortBy: state.sortBy,
      refresh: true,
    );
  }

  void setTag(String? tag) {
    if (tag != state.currentTag) {
      loadWallpapers(tag: tag, refresh: true);
    }
  }

  void clearTag() {
    if (state.currentTag != null) {
      loadWallpapers(tag: null, refresh: true);
    }
  }
}

final wallpapersProvider =
    StateNotifierProvider<WallpapersNotifier, WallpapersState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return WallpapersNotifier(apiService);
});

// ============ Computed Providers ============

final favoriteWallpapersProvider = Provider<List<Wallpaper>>((ref) {
  final wallpapers = ref.watch(wallpapersProvider).wallpapers;
  final favoriteIds = ref.watch(favoritesProvider);
  return wallpapers.where((w) => favoriteIds.contains(w.id)).toList();
});

final tagWallpapersProvider =
    Provider.family<List<Wallpaper>, String>((ref, tagSlug) {
  final wallpapers = ref.watch(wallpapersProvider).wallpapers;
  return wallpapers
      .where((w) => w.tags.any((t) => t.slug == tagSlug))
      .toList();
});

// ============ Hero Wallpapers Provider ============

class HeroWallpapersNotifier extends StateNotifier<List<Wallpaper>> {
  final ApiService _apiService;

  HeroWallpapersNotifier(this._apiService) : super([]);

  Future<void> load() async {
    if (state.isNotEmpty) return;
    try {
      final response = await _apiService.getWallpapers(
        page: 1,
        limit: 8,
        sort: 'random',
      );
      state = response.wallpapers;
    } catch (_) {
      // Silently fail - hero section will show gradient fallback
    }
  }

  Future<void> refresh() async {
    try {
      final response = await _apiService.getWallpapers(
        page: 1,
        limit: 8,
        sort: 'random',
      );
      state = response.wallpapers;
    } catch (_) {}
  }
}

final heroWallpapersProvider =
    StateNotifierProvider<HeroWallpapersNotifier, List<Wallpaper>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return HeroWallpapersNotifier(apiService);
});

// ============ Navigation State ============

final selectedTabProvider = StateProvider<int>((ref) => 0);
