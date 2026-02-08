import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final Map<String, String> tags;
  final IconData icon;
  final String? githubUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    this.githubUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.cardBorder,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.icon,
                    color: AppColors.accent,
                    size: 24,
                  ),
                ),
                const Spacer(),
                if (widget.githubUrl != null)
                  IconButton(
                    onPressed: () => launchUrl(Uri.parse(widget.githubUrl!)),
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    tooltip: 'View on GitHub',
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.tags.entries.map((entry) {
                return _TagChip(label: entry.key, url: entry.value);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatefulWidget {
  final String label;
  final String url;

  const _TagChip({required this.label, required this.url});

  @override
  State<_TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<_TagChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.2)
                : AppColors.tagBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.accent,
              fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
              decoration:
                  _isHovered ? TextDecoration.underline : TextDecoration.none,
              decorationColor: AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}
