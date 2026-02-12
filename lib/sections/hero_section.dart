import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';
import '../widgets/animated_background.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onScrollDown;

  const HeroSection({super.key, this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: const AnimatedBackground(),
          ),
        ),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 40,
          ),
          child: isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context, screenHeight),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenHeight) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildContent(context, false),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildProfileImage(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        _buildProfileImage(radius: 150),
        const SizedBox(height: 40),
        _buildContent(context, true),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildProfileImage({double radius = 150}) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.3), width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.surface,
          backgroundImage: const AssetImage('assets/images/Tone Jali.png'),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          ),
          child: const Text(
            'Available for DevOps & SRE roles',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Mongezi Tone Jali',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 36 : 56,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'Full-Stack Developer  \u2192  DevOps & SRE Engineer',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: isMobile ? 18 : 24,
            fontWeight: FontWeight.w600,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Building reliable, scalable cloud infrastructure with .NET, Azure, '
          'and modern DevOps practices. From shipping production APIs to '
          'designing monitoring stacks and CI/CD pipelines.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            _SocialButton(
              icon: FontAwesomeIcons.linkedin,
              label: 'LinkedIn',
              onTap: () => launchUrl(Uri.parse(
                  'https://linkedin.com/in/mongezi-tone-jali-90184921a')),
            ),
            _SocialButton(
              icon: Icons.email_outlined,
              label: 'Email',
              onTap: () => launchUrl(Uri.parse('mailto:mongezitone@gmail.com')),
            ),
            _SocialButton(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              onTap: () =>
                  launchUrl(Uri.parse('https://github.com/MongeziTone')),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const _ResumeButton(),
        const SizedBox(height: 48),
        if (onScrollDown != null)
          GestureDetector(
            onTap: onScrollDown,
            child: Column(
              children: [
                Text(
                  'Scroll to explore',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                const _BouncingArrow(),
              ],
            ),
          ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.1)
                : AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: _isHovered ? AppColors.accent : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      _isHovered ? AppColors.accent : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  const _ResumeButton();

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse('Mongezi_Tone_Jali_Resume.pdf')),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent
                : AppColors.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.accent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 18,
                color: _isHovered ? AppColors.background : AppColors.accent,
              ),
              const SizedBox(width: 8),
              Text(
                'Download Resume',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _isHovered ? AppColors.background : AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BouncingArrow extends StatefulWidget {
  const _BouncingArrow();

  @override
  State<_BouncingArrow> createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<_BouncingArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _controller.value * 8),
          child: child,
        );
      },
      child: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.accent,
        size: 28,
      ),
    );
  }
}
