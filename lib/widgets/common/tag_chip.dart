import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../config/spacing.dart';

class TagChip extends StatelessWidget {
  final String label;
  final int? count;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool showCount;

  const TagChip({
    super.key,
    required this.label,
    this.count,
    this.isSelected = false,
    this.onTap,
    this.showCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space3,
          vertical: AppSpacing.space2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            if (showCount && count != null) ...[
              const SizedBox(width: AppSpacing.space1),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space2,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.3)
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  count.toString(),
                  style: AppTypography.dataSmall.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class TrendingTagChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool hasGradient;

  const TrendingTagChip({
    super.key,
    required this.label,
    this.onTap,
    this.hasGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
        ),
        decoration: BoxDecoration(
          gradient: hasGradient ? AppColors.primaryGradient : null,
          color: hasGradient ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: hasGradient ? null : Border.all(color: AppColors.border),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: hasGradient ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
