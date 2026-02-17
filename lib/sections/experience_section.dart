import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/timeline_tile.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
            child: Column(
              children: [
                Text(
                  'Experience & Education',
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
            ),
          ),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Column(
              children: [
                ScrollReveal(
                  delay: Duration(milliseconds: 100),
                  child: TimelineTile(
                    title: 'Junior Full Stack Developer',
                    subtitle: 'OOGi Lab \u2022 Durban North, South Africa',
                    subtitleUrl: 'https://www.oogi.ai/',
                    period: 'Jan 2023 - Present',
                    icon: Icons.work_outline,
                    points: [
                      'Developed and maintained .NET Core APIs for a cloud-based AI and IoT fleet management platform serving logistics clients including Australia Post.',
                      'Built core services for vehicle tracking, driver behavior analysis, real-time AI camera monitoring, and driver learning tools.',
                      'Designed observer-based architecture with C# and ASP.NET for API endpoints, services, repositories, and unit/integration tests.',
                      'Implemented SQL Server databases using Liquibase for migrations, with query integration into the .NET backend.',
                      'Managed Azure Functions for device event streams, external integrations (webhooks, Geotab), and real-time processing pipelines.',
                      'Set up and maintained Prometheus, Grafana, and Alertmanager monitoring stack with custom PromQL dashboards.',
                      'Built mobile and web apps in Flutter using Bloc architecture with Mapbox and Flutter Maps.',
                      'Designed real-time streaming architecture for IoT camera feeds with Nginx and secure authentication layers.',
                      'Supported team DevOps workflows using Docker for local dev storage and containerized virtual machines.',
                    ],
                  ),
                ),
                ScrollReveal(
                  delay: Duration(milliseconds: 200),
                  child: TimelineTile(
                    title:
                        'National Certificate: INFORMATION TECHNOLOGY: Systems Development',
                    subtitle: 'WeThinkCode',
                    period: '2022',
                    icon: Icons.school_outlined,
                    isLast: true,
                    certificateUrl: 'NQF-Level5_Certificates.pdf',
                    points: [
                      'NQF Level 5 (NLRD No.48872) — SAQA registered qualification.',
                      'Computer Software Engineering bootcamp covering full-stack development fundamentals.',
                      'Studied Java, Python, JavaScript, Git, OOP, Web APIs, Docker, SQL, Linux, and Maven.',
                      'Gained hands-on experience with Agile methodologies, architectural patterns, and system integration.',
                    ],
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
