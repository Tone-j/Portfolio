import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../widgets/scroll_reveal.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          ScrollReveal(
            child: _buildSectionTitle(context),
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: [
                ScrollReveal(
                  delay: const Duration(milliseconds: 100),
                  child: _buildAboutText(context),
                ),
                const SizedBox(height: 32),
                ScrollReveal(
                  delay: const Duration(milliseconds: 200),
                  child: _buildHighlights(context),
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 100),
                    child: _buildAboutText(context),
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 2,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 200),
                    child: _buildHighlights(context),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          'About Me',
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
      ],
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Journey',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m a full-stack developer at OOGi Lab, where I\'ve spent 3+ years building '
          'cloud-based AI and IoT fleet management platforms serving major logistics clients '
          'including Australia Post. My work spans the entire stack \u2014 from designing .NET Core '
          'APIs and SQL Server databases to building Flutter mobile apps and real-time IoT dashboards.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Through hands-on experience managing Azure Functions, building Prometheus/Grafana '
          'monitoring stacks, designing CI/CD pipelines, and containerizing services with Docker, '
          'I\'ve developed a deep passion for infrastructure, reliability, and automation. This '
          'naturally led me toward DevOps, Platform Engineering, and Site Reliability Engineering.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m now actively transitioning into DevOps/SRE roles, combining my strong development '
          'background with growing expertise in cloud infrastructure, container orchestration, '
          'and observability to build systems that are reliable, scalable, and automated.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildHighlights(BuildContext context) {
    final highlights = [
      const _Highlight(
          Icons.cloud_outlined, '3+ Years', 'Production Cloud Experience'),
      const _Highlight(Icons.api, 'APIs & Microservices', '.NET Core / Azure'),
      const _Highlight(
          Icons.monitor_heart_outlined, 'Monitoring', 'Prometheus / Grafana'),
      const _Highlight(Icons.integration_instructions, 'CI/CD Pipelines',
          'Azure DevOps / GitHub Actions'),
      const _Highlight(
          Icons.language, 'Languages', 'English, isiZulu, isiXhosa'),
    ];

    return Column(
      children: highlights
          .map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(h.icon, color: AppColors.accent, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              h.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              h.subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _Highlight {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Highlight(this.icon, this.title, this.subtitle);
}
