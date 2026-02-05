import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Privacy Policy', style: AppTypography.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: January 2024',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.space6),
            _buildSection(
              'INFORMATION WE COLLECT',
              'Walls of Art does not collect any personal information. All your preferences, favorites, and settings are stored locally on your device and are not transmitted to our servers.',
            ),
            _buildSection(
              'LOCAL DATA STORAGE',
              '''The app stores the following data locally on your device:
• Favorite wallpaper IDs
• Cached images for offline viewing
• App preferences

This data never leaves your device unless you explicitly choose to back it up through your device's backup system.''',
            ),
            _buildSection(
              'THIRD-PARTY SERVICES',
              '''a) Google AdMob
We use Google AdMob to display advertisements. AdMob may collect and use data to personalize ads. For more information, see Google's Privacy Policy: https://policies.google.com/privacy

b) Wallpaper Sources
Wallpapers displayed in this app are sourced from publicly available content on platforms like Reddit and WallHaven. We do not claim ownership of these images.''',
            ),
            _buildSection(
              'CHILDREN\'S PRIVACY',
              'This app is not intended for children under 13. We do not knowingly collect personal information from children.',
            ),
            _buildSection(
              'CHANGES TO THIS POLICY',
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy in the app.',
            ),
            _buildSection(
              'CONTACT US',
              'If you have questions about this Privacy Policy, please contact us at: support@wallsofart.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            content,
            style: AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }
}
