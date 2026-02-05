import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';
import '../../config/routes.dart';
import '../../providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesCount = ref.watch(favoritesProvider).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Settings', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.space4),
        children: [
          // Storage Section
          _buildSectionHeader('STORAGE'),
          _buildSettingsTile(
            icon: Icons.folder_outlined,
            title: 'Clear Image Cache',
            subtitle: 'Free up storage space',
            onTap: () => _showClearCacheDialog(context, ref),
          ),
          _buildSettingsTile(
            icon: Icons.favorite_outline,
            title: 'Clear All Favorites',
            subtitle: '$favoritesCount wallpapers saved',
            onTap: favoritesCount > 0
                ? () => _showClearFavoritesDialog(context, ref)
                : null,
          ),
          const SizedBox(height: AppSpacing.space6),

          // Legal Section
          _buildSectionHeader('LEGAL'),
          _buildSettingsTile(
            icon: Icons.description_outlined,
            title: 'Privacy Policy',
            trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
            onTap: () => context.push(AppRoutes.privacy),
          ),
          _buildSettingsTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
            onTap: () => context.push(AppRoutes.terms),
          ),
          const SizedBox(height: AppSpacing.space6),

          // About Section
          _buildSectionHeader('ABOUT'),
          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: '1.0.0 (Build 1)',
            onTap: null,
          ),
          _buildSettingsTile(
            icon: Icons.star_outline,
            title: 'Rate This App',
            trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
            onTap: () => _rateApp(),
          ),
          _buildSettingsTile(
            icon: Icons.bug_report_outlined,
            title: 'Report a Bug',
            trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
            onTap: () => _reportBug(),
          ),
          const SizedBox(height: AppSpacing.space10),

          // Footer
          Center(
            child: Column(
              children: [
                Text(
                  'Made with ❤️ by Muhammad Komail',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppSpacing.space1),
                Text(
                  '© 2024 Walls of Art',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.space2,
        bottom: AppSpacing.space2,
      ),
      child: Text(
        title,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textMuted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(title, style: AppTypography.titleMedium),
        subtitle: subtitle != null
            ? Text(subtitle, style: AppTypography.bodySmall)
            : null,
        trailing: trailing,
        onTap: onTap,
        enabled: onTap != null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Clear Cache', style: AppTypography.headlineMedium),
        content: Text(
          'This will delete all cached images. You can re-download them anytime.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(cacheServiceProvider).clearAll();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cache cleared'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showClearFavoritesDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Clear Favorites', style: AppTypography.headlineMedium),
        content: Text(
          'This will remove all your saved wallpapers. This action cannot be undone.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(favoritesProvider.notifier).clearAll();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Favorites cleared'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _rateApp() {
    // TODO: Implement app store rating
  }

  void _reportBug() async {
    final uri = Uri.parse('mailto:support@wallsofart.com?subject=Bug Report');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
