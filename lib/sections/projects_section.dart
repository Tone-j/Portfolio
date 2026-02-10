import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
                  'Projects',
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
                const SizedBox(height: 12),
                Text(
                  'Production systems and platforms I\'ve built and contributed to',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          _buildProjectGrid(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildProjectGrid(BuildContext context, bool isMobile) {
    final projects = [
      const _Project(
        title: 'AdsRunner - Taxi Billboard Advertising Platform',
        description:
            'Cloud-native SaaS platform for managing digital billboard advertisements on '
            'public transport vehicles. Built a full-stack solution featuring ad campaign '
            'management, real-time analytics, passenger monitoring, and subscription services. '
            'Leverages microservices architecture with Azure cloud infrastructure.',
        tags: {
          'Flutter': 'https://docs.flutter.dev/',
          'C# / .NET 8': 'https://learn.microsoft.com/en-us/dotnet/',
          'Azure': 'https://learn.microsoft.com/en-us/azure/',
          'SQL Server': 'https://learn.microsoft.com/en-us/sql/sql-server/',
          'Azure IoT Hub': 'https://learn.microsoft.com/en-us/azure/iot-hub/',
          'Cosmos DB': 'https://learn.microsoft.com/en-us/azure/cosmos-db/',
        },
        icon: Icons.analytics,
        liveUrl: 'https://tone-j.github.io/ads_runner',
        githubUrl: 'https://github.com/Tone-j/ads_runner.git',
        status: 'In Development',
        demoCredentials: 'Email: JohnMitchell@mail.com\nPassword: Pass12345',
      ),
      const _Project(
        title: 'Fleet Management API Platform',
        description:
            'Developed and maintained .NET Core APIs for a cloud-based AI and IoT fleet '
            'management platform used by logistics clients including Australia Post. Built '
            'core services for vehicle tracking, driver behavior analysis, and real-time '
            'AI camera monitoring.',
        tags: {
          '.NET Core':
              'https://learn.microsoft.com/en-us/dotnet/core/introduction',
          'Azure': 'https://learn.microsoft.com/en-us/azure/',
          'SQL Server': 'https://learn.microsoft.com/en-us/sql/sql-server/',
          'REST API': 'https://learn.microsoft.com/en-us/aspnet/core/web-api/',
          'IoT': 'https://learn.microsoft.com/en-us/azure/iot/',
        },
        icon: Icons.local_shipping,
      ),
      const _Project(
        title: 'Infrastructure Monitoring Stack',
        description:
            'Set up and maintained a complete Prometheus, Grafana, and Alertmanager '
            'monitoring stack for Azure services, APIs, databases, and IoT devices. '
            'Designed custom PromQL dashboards for real-time observability and alerting.',
        tags: {
          'Prometheus': 'https://prometheus.io/docs/introduction/overview/',
          'Grafana': 'https://grafana.com/docs/grafana/latest/',
          'Alertmanager':
              'https://prometheus.io/docs/alerting/latest/alertmanager/',
          'PromQL':
              'https://prometheus.io/docs/prometheus/latest/querying/basics/',
          'Azure': 'https://learn.microsoft.com/en-us/azure/',
        },
        icon: Icons.monitor_heart,
      ),
      const _Project(
        title: 'Cloud Messaging System',
        description:
            'Led cloud messaging system implementation using Firebase, Supabase, and '
            'Hive for mobile and web push notifications. Integrated Flutter frontend '
            'with .NET backend services for real-time notification delivery.',
        tags: {
          'Firebase': 'https://firebase.google.com/docs',
          'Supabase': 'https://supabase.com/docs',
          'Flutter': 'https://docs.flutter.dev/',
          '.NET': 'https://learn.microsoft.com/en-us/dotnet/',
          'Hive': 'https://docs.hivedb.dev/',
        },
        icon: Icons.notifications_active,
      ),
      const _Project(
        title: 'Real-time IoT Camera Streaming',
        description:
            'Designed real-time streaming architecture for IoT camera feeds with Nginx '
            'media servers and secure authentication layers. Implemented event-driven '
            'processing pipelines using Azure Functions for device event streams.',
        tags: {
          'Nginx': 'https://nginx.org/en/docs/',
          'Azure Functions':
              'https://learn.microsoft.com/en-us/azure/azure-functions/',
          'IoT': 'https://learn.microsoft.com/en-us/azure/iot/',
          'Streaming': 'https://learn.microsoft.com/en-us/azure/event-hubs/',
          'Docker': 'https://docs.docker.com/',
        },
        icon: Icons.videocam,
      ),
    ];

    if (isMobile) {
      return Column(
        children: projects.asMap().entries.map((entry) {
          return ScrollReveal(
            delay: Duration(milliseconds: entry.key * 100),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProjectCard(
                title: entry.value.title,
                description: entry.value.description,
                tags: entry.value.tags,
                icon: entry.value.icon,
                liveUrl: entry.value.liveUrl,
                githubUrl: entry.value.githubUrl,
                status: entry.value.status,
                demoCredentials: entry.value.demoCredentials,
              ),
            ),
          );
        }).toList(),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.3,
      children: projects.asMap().entries.map((entry) {
        return ScrollReveal(
          delay: Duration(milliseconds: entry.key * 100),
          child: ProjectCard(
            title: entry.value.title,
            description: entry.value.description,
            tags: entry.value.tags,
            icon: entry.value.icon,
            liveUrl: entry.value.liveUrl,
            githubUrl: entry.value.githubUrl,
            status: entry.value.status,
            demoCredentials: entry.value.demoCredentials,
          ),
        );
      }).toList(),
    );
  }
}

class _Project {
  final String title;
  final String description;
  final Map<String, String> tags;
  final IconData icon;
  final String? liveUrl;
  final String? githubUrl;
  final String? status;
  final String? demoCredentials;
  const _Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    this.liveUrl,
    this.githubUrl,
    this.status,
    this.demoCredentials,
  });
}
