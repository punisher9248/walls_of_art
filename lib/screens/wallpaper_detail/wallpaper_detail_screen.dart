import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';
import '../../config/routes.dart';
import '../../providers/providers.dart';
import '../../models/models.dart';
import '../../services/wallpaper_service.dart';
import '../../services/permission_service.dart';
import '../../utils/image_proxy.dart';

class WallpaperDetailScreen extends ConsumerStatefulWidget {
  final String wallpaperId;

  const WallpaperDetailScreen({super.key, required this.wallpaperId});

  @override
  ConsumerState<WallpaperDetailScreen> createState() =>
      _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends ConsumerState<WallpaperDetailScreen> {
  Wallpaper? _wallpaper;
  bool _isSettingWallpaper = false;
  bool _isDownloading = false;
  double _downloadProgress = 0;

  @override
  void initState() {
    super.initState();
    // Find wallpaper from current list
    Future.microtask(() {
      final wallpapers = ref.read(wallpapersProvider).wallpapers;
      final found = wallpapers.where((w) => w.id == widget.wallpaperId);
      if (found.isNotEmpty) {
        setState(() => _wallpaper = found.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = _wallpaper != null && favorites.contains(_wallpaper!.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _wallpaper == null
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : CustomScrollView(
              slivers: [
                // App bar with image
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.45,
                  pinned: true,
                  backgroundColor: AppColors.background,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.background.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                    onPressed: () => context.pop(),
                  ),
                  actions: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.share),
                      ),
                      onPressed: () => _shareWallpaper(),
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.fullscreen),
                      ),
                      onPressed: () => _showFullscreen(context),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'wallpaper_${_wallpaper!.id}',
                      child: CachedNetworkImage(
                        imageUrl: ImageProxy.getUrl(_wallpaper!.previewUrl),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.surface,
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
                            Icons.error_outline,
                            color: AppColors.textMuted,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ID Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space3,
                            vertical: AppSpacing.space1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusSm,
                            ),
                          ),
                          child: Text(
                            'No. ${_wallpaper!.shortId}',
                            style: AppTypography.dataMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space3),
                        // Title
                        Text(
                          _wallpaper!.title,
                          style: AppTypography.headlineLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.space3),
                        // Metadata
                        Text(
                          '${_wallpaper!.dimensionsText}  •  ${_wallpaper!.megapixelsText}  •  ${_wallpaper!.aspectRatioText}',
                          style: AppTypography.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.space6),
                        // Primary action button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _isSettingWallpaper
                                ? null
                                : () => _showSetWallpaperDialog(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.space4,
                              ),
                            ),
                            icon: _isSettingWallpaper
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.textPrimary,
                                    ),
                                  )
                                : const Icon(Icons.wallpaper),
                            label: Text(
                              _isSettingWallpaper
                                  ? 'Setting...'
                                  : 'Set Wallpaper',
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space3),
                        // Secondary actions
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _isDownloading ? null : () => _downloadWallpaper(),
                                icon: _isDownloading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          value: _downloadProgress > 0 ? _downloadProgress : null,
                                          strokeWidth: 2,
                                          color: AppColors.primary,
                                        ),
                                      )
                                    : const Icon(Icons.download),
                                label: Text(_isDownloading ? 'Saving...' : 'Save'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space3),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(favoritesProvider.notifier)
                                      .toggleFavorite(
                                        _wallpaper!.id,
                                        downloadUrl: _wallpaper!.downloadUrl,
                                      );
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: isFavorite
                                      ? AppColors.secondary
                                      : null,
                                ),
                                label: Text(
                                  isFavorite ? 'Saved' : 'Favorite',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.space6),
                        // Tags
                        if (_wallpaper!.tags.isNotEmpty) ...[
                          Text('Tags:', style: AppTypography.titleMedium),
                          const SizedBox(height: AppSpacing.space2),
                          Wrap(
                            spacing: AppSpacing.space2,
                            runSpacing: AppSpacing.space2,
                            children: _wallpaper!.tags.map((tag) {
                              return ActionChip(
                                label: Text(tag.name),
                                onPressed: () {
                                  context.push(
                                    '${AppRoutes.tagPath(tag.slug)}?name=${tag.name}',
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: AppSpacing.space6),
                        ],
                        // Source
                        if (_wallpaper!.sourceUrl != null) ...[
                          Text(
                            'Source: ${_wallpaper!.source}${_wallpaper!.subreddit != null ? ' • r/${_wallpaper!.subreddit}' : ''}',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _showFullscreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: ImageProxy.getUrl(_wallpaper!.downloadUrl),
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSetWallpaperDialog(BuildContext context) {
    final wallpaperService = ref.read(wallpaperServiceProvider);

    if (!wallpaperService.canSetWallpaperDirectly) {
      // iOS - just download and show instructions
      _downloadWallpaper(showInstructions: true);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Set Wallpaper', style: AppTypography.headlineMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose where to apply this wallpaper',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.space4),
            _buildWallpaperOption(
              context,
              icon: Icons.home,
              label: 'Home Screen',
              target: WallpaperTarget.home,
            ),
            const SizedBox(height: AppSpacing.space2),
            _buildWallpaperOption(
              context,
              icon: Icons.lock,
              label: 'Lock Screen',
              target: WallpaperTarget.lock,
            ),
            const SizedBox(height: AppSpacing.space2),
            _buildWallpaperOption(
              context,
              icon: Icons.auto_awesome,
              label: 'Both (Recommended)',
              target: WallpaperTarget.both,
              isPrimary: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaperOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required WallpaperTarget target,
    bool isPrimary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: isPrimary
          ? ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _setWallpaper(target);
              },
              icon: Icon(icon),
              label: Text(label),
            )
          : OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _setWallpaper(target);
              },
              icon: Icon(icon),
              label: Text(label),
            ),
    );
  }

  Future<void> _setWallpaper(WallpaperTarget target) async {
    setState(() => _isSettingWallpaper = true);

    final wallpaperService = ref.read(wallpaperServiceProvider);
    final result = await wallpaperService.setWallpaper(
      _wallpaper!.downloadUrl,
      target: target,
    );

    setState(() => _isSettingWallpaper = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor:
              result.success ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _shareWallpaper() async {
    if (_wallpaper == null) return;

    try {
      await SharePlus.instance.share(ShareParams(
       title: 'Check out this amazing wallpaper from Walls of Art!\n\n'
        '${_wallpaper!.title}\n'
        '${_wallpaper!.downloadUrl}',
        subject: 'Walls of Art - ${_wallpaper!.title}',
      ));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _downloadWallpaper({bool showInstructions = false}) async {
    if (_wallpaper == null || _isDownloading) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    final downloadService = ref.read(downloadServiceProvider);
    final result = await downloadService.downloadWallpaper(
      _wallpaper!.downloadUrl,
      fileName: 'wallsofart_${_wallpaper!.shortId}.jpg',
      onProgress: (received, total) {
        if (total > 0) {
          setState(() {
            _downloadProgress = received / total;
          });
        }
      },
    );

    setState(() {
      _isDownloading = false;
      _downloadProgress = 0;
    });

    if (!mounted) return;

    // Handle permission denied - show dialog to open settings
    if (result.permissionPermanentlyDenied) {
      _showPermissionSettingsDialog();
      return;
    }

    if (result.permissionDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Permission required to save wallpapers'),
          backgroundColor: AppColors.error,
          action: SnackBarAction(
            label: 'Settings',
            textColor: Colors.white,
            onPressed: () => PermissionService.openSettings(),
          ),
        ),
      );
      return;
    }

    // Normal success/error handling
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.message),
        backgroundColor: result.success ? AppColors.success : AppColors.error,
        action: showInstructions && result.success
            ? SnackBarAction(
                label: 'Set as Wallpaper',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Open Photos app and set as wallpaper from there'),
                      duration: Duration(seconds: 4),
                    ),
                  );
                },
              )
            : null,
      ),
    );
  }

  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        icon: Icon(
          Icons.folder_off_outlined,
          color: AppColors.warning,
          size: 48,
        ),
        title: Text(
          'Permission Required',
          style: AppTypography.headlineMedium,
        ),
        content: Text(
          'Storage permission was denied. To save wallpapers, '
          'please enable storage access in your device settings.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              PermissionService.openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
