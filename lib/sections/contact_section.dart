import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';
import '../widgets/scroll_reveal.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      color: AppColors.surface,
      child: Column(
        children: [
          ScrollReveal(
            child: Column(
              children: [
                Text(
                  'Let\'s Connect',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 12),
                Container(
                  width: 60,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    'I\'m actively looking for Entry DevOps, Platform Engineering, and SRE opportunities. '
                    'Feel free to reach out!',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          ScrollReveal(
            delay: const Duration(milliseconds: 100),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _ContactTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: 'mongezitone@gmail.com',
                  onTap: () =>
                      launchUrl(Uri.parse('mailto:mongezitone@gmail.com')),
                ),
                _ContactTile(
                  icon: FontAwesomeIcons.linkedin,
                  title: 'LinkedIn',
                  value: 'Mongezi Tone Jali',
                  onTap: () => launchUrl(Uri.parse(
                      'https://linkedin.com/in/mongezi-tone-jali-90184921a')),
                ),
                _ContactTile(
                  icon: FontAwesomeIcons.github,
                  title: 'GitHub',
                  value: 'github.com',
                  onTap: () => launchUrl(Uri.parse('https://github.com/')),
                ),
                const _ContactTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  value: 'Durban North, KZN, South Africa',
                  onTap: null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          ScrollReveal(
            delay: const Duration(milliseconds: 200),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.cardBorder,
                ),
                const SizedBox(height: 24),
                Text(
                  '\u00a9 ${DateTime.now().year} Mongezi Tone Jali.',
                  style: TextStyle(
                    fontSize: 13,
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
}

class _ContactTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<_ContactTile> {
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
          width: 240,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered && widget.onTap != null
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : AppColors.cardBorder,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: AppColors.accent, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: widget.onTap != null && _isHovered
                      ? AppColors.accent
                      : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
