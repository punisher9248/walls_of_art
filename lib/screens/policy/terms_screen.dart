import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
        title: Text('Terms of Service', style: AppTypography.headlineMedium),
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
              'ACCEPTANCE OF TERMS',
              'By downloading or using Walls of Art, you agree to these Terms of Service.',
            ),
            _buildSection(
              'USE OF THE APP',
              '''You may use this app for personal, non-commercial purposes only. You agree not to:
• Redistribute wallpapers commercially
• Claim ownership of wallpapers
• Use the app for any illegal purpose''',
            ),
            _buildSection(
              'WALLPAPER CONTENT',
              'Wallpapers are sourced from public platforms (Reddit, WallHaven). We do not claim ownership of these images. If you are a copyright holder and believe your content is being used inappropriately, please contact us.',
            ),
            _buildSection(
              'ADVERTISEMENTS',
              'This app displays advertisements through Google AdMob. By using this app, you agree to view these advertisements.',
            ),
            _buildSection(
              'DISCLAIMER',
              'THE APP IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. WE DO NOT GUARANTEE THAT THE APP WILL BE ERROR-FREE OR UNINTERRUPTED.',
            ),
            _buildSection(
              'LIMITATION OF LIABILITY',
              'IN NO EVENT SHALL WE BE LIABLE FOR ANY INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING FROM YOUR USE OF THE APP.',
            ),
            _buildSection(
              'CHANGES TO TERMS',
              'We reserve the right to modify these terms at any time. Continued use of the app after changes constitutes acceptance of new terms.',
            ),
            _buildSection(
              'CONTACT',
              'For questions about these Terms, contact us at: support@wallsofart.com',
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
