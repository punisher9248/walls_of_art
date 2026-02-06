import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../config/colors.dart';
import '../config/routes.dart';
import '../providers/providers.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: bottomPadding + 12,
        ),
        child: _FloatingNavBar(
          selectedIndex: selectedTab,
          onTap: (index) {
            ref.read(selectedTabProvider.notifier).state = index;
            switch (index) {
              case 0:
                context.go(AppRoutes.home);
                break;
              case 1:
                context.go(AppRoutes.gallery);
                break;
              case 2:
                context.go(AppRoutes.favorites);
                break;
            }
          },
        ),
      ),
    );
  }
}

// ============ Floating Nav Bar ============

class _FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  // FAB is 60px, so radius = 30. Dome is slightly larger.
  // static const double _fabSize = 60;
  static const double _fabSize = 50;
  static const double _domeRadius = 40;
  // static const double _domeRadius = 36;
  // static const double _barHeight = 64;
  static const double _barHeight = 70;
  // static const double _totalHeight = 80;
  static const double _totalHeight = 70;

  const _FloatingNavBar({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Painted background: bar + dome
          Positioned.fill(
            child: CustomPaint(
              painter: _NavBarPainter(
                color: const Color(0xFF161B2E),
                borderColor: Colors.white.withValues(alpha: 0.06),
                barTop: _totalHeight - _barHeight,
                domeRadius: _domeRadius,
                fabCenterY: _fabSize / 2,
              ),
            ),
          ),
          // Nav item row (sits inside the bar area)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _barHeight,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavItem(
                        icon: Icons.home_outlined,
                        selectedIcon: Icons.home_rounded,
                        isSelected: selectedIndex == 0,
                        onTap: () => onTap(0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavItem(
                        icon: Icons.favorite_border_rounded,
                        selectedIcon: Icons.favorite_rounded,
                        isSelected: selectedIndex == 2,
                        onTap: () => onTap(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Center FAB
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _CenterFab(
                isSelected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============ Custom Painter: bar + dome ============

class _NavBarPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double barTop;
  final double domeRadius;
  final double fabCenterY;

  _NavBarPainter({
    required this.color,
    required this.borderColor,
    required this.barTop,
    required this.domeRadius,
    required this.fabCenterY,
  });

  static const double _cornerRadius = 20;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    // Shadow
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.6), 16, true);

    // Fill
    canvas.drawPath(path, Paint()..color = color);

    // Border stroke
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  Path _buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // Rounded rect for the bar body
    final barPath = Path()
      ..addRRect(
        RRect.fromLTRBR(0, barTop, w, h, const Radius.circular(_cornerRadius)),
      );

    // Circle dome behind the FAB
    final domePath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(cx, fabCenterY),
          radius: domeRadius,
        ),
      );

    // Union: bar + dome = one continuous shape
    return Path.combine(PathOperation.union, barPath, domePath);
  }

  @override
  bool shouldRepaint(covariant _NavBarPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.barTop != barTop ||
      oldDelegate.domeRadius != domeRadius ||
      oldDelegate.fabCenterY != fabCenterY;
}

// ============ Nav Item ============

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        height: 56,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isSelected ? selectedIcon : icon,
              key: ValueKey(isSelected),
              color: isSelected ? AppColors.textPrimary : AppColors.textMuted,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}

// ============ Center FAB ============

class _CenterFab extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _CenterFab({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [AppColors.primary, AppColors.primaryDark]
                : [
                    AppColors.primary.withValues(alpha: 0.7),
                    AppColors.primaryDark.withValues(alpha: 0.7),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color:
                  AppColors.primary.withValues(alpha: isSelected ? 0.5 : 0.3),
              blurRadius: isSelected ? 20 : 12,
              spreadRadius: isSelected ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.grid_view_rounded,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
