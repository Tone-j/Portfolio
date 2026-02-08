import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';
import '../widgets/nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/certifications_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';

class PortfolioPage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const PortfolioPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _activeSection = 0;

  final List<String> _sectionLabels = const [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Certifications',
    'Experience',
    'Contact',
  ];

  final List<GlobalKey> _sectionKeys = List.generate(
    7,
    (_) => GlobalKey(),
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }

    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 150) {
          if (_activeSection != i) {
            setState(() => _activeSection = i);
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildSection(0, HeroSection(
                  onScrollDown: () => _scrollToSection(1),
                )),
                _buildSection(1, const AboutSection()),
                _buildSection(2, const SkillsSection()),
                _buildSection(3, const ProjectsSection()),
                _buildSection(4, const CertificationsSection()),
                _buildSection(5, const ExperienceSection()),
                _buildSection(6, const ContactSection()),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              sections: _sectionLabels,
              activeIndex: _activeSection,
              onTap: _scrollToSection,
              isScrolled: _isScrolled,
              isDark: widget.isDark,
              onToggleTheme: widget.onToggleTheme,
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: _FloatingContactButton(
              onTap: () => launchUrl(Uri.parse('mailto:mongezitone@gmail.com')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(int index, Widget child) {
    return Container(
      key: _sectionKeys[index],
      child: child,
    );
  }
}

class _FloatingContactButton extends StatefulWidget {
  final VoidCallback onTap;
  const _FloatingContactButton({required this.onTap});

  @override
  State<_FloatingContactButton> createState() =>
      _FloatingContactButtonState();
}

class _FloatingContactButtonState extends State<_FloatingContactButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: _isHovered ? 20 : 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.accent : AppColors.accent.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(_isHovered ? 28 : 50),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.email_outlined,
                color: AppColors.background,
                size: 22,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: _isHovered
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Get in Touch',
                          style: TextStyle(
                            color: AppColors.background,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
