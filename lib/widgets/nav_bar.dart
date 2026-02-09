import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class NavBar extends StatelessWidget {
  final List<String> sections;
  final int activeIndex;
  final Function(int) onTap;
  final bool isScrolled;
  final bool isDark;
  final VoidCallback onToggleTheme;

  const NavBar({
    super.key,
    required this.sections,
    required this.activeIndex,
    required this.onTap,
    this.isScrolled = false,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.navBackground : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.cardBorder : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onTap(0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'icons/my_avator.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Tone',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (isMobile)
            _MobileMenu(
              sections: sections,
              activeIndex: activeIndex,
              onTap: onTap,
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(sections.length, (index) {
                final isActive = index == activeIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextButton(
                    onPressed: () => onTap(index),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          isActive ? AppColors.accent : AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      sections[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            ),
          const SizedBox(width: 4),
          // Theme toggle
          IconButton(
            onPressed: onToggleTheme,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(isDark),
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
          ),
        ],
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final List<String> sections;
  final int activeIndex;
  final Function(int) onTap;

  const _MobileMenu({
    required this.sections,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.menu, color: AppColors.textPrimary),
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.cardBorder),
      ),
      onSelected: onTap,
      itemBuilder: (context) => List.generate(sections.length, (index) {
        return PopupMenuItem(
          value: index,
          child: Text(
            sections[index],
            style: TextStyle(
              color: index == activeIndex
                  ? AppColors.accent
                  : AppColors.textSecondary,
              fontWeight:
                  index == activeIndex ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        );
      }),
    );
  }
}
