import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/colors.dart';
import '../../config/spacing.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onToggle;
  final double size;
  final Color? backgroundColor;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    this.size = 20,
    this.backgroundColor,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    _controller.forward().then((_) => _controller.reverse());
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space2),
        decoration: BoxDecoration(
          color: widget.backgroundColor ??
              AppColors.background.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: widget.isFavorite ? AppColors.secondary : AppColors.textPrimary,
            size: widget.size,
          ),
        ),
      ),
    );
  }
}
