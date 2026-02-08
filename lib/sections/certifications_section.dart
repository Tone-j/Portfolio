import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/cert_card.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

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
                  'Certifications',
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
                  'Professional certifications I\'m currently pursuing and completed',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          _buildCertGrid(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildCertGrid(BuildContext context, bool isMobile) {
    final certs = [
      const _Cert(
        title: 'AZ-900: Azure Fundamentals',
        issuer: 'Microsoft',
        description:
            'Cloud concepts, Azure services, security, privacy, compliance, '
            'trust, and Azure pricing and support.',
        icon: Icons.cloud,
        inProgress: false,
        credentialUrl: '',
      ),
      const _Cert(
        title: 'AZ-104: Azure Administrator',
        issuer: 'Microsoft',
        description:
            'Managing Azure identities, governance, storage, compute, and '
            'virtual networks in a cloud environment.',
        icon: Icons.admin_panel_settings,
      ),
      const _Cert(
        title: 'CKA: Certified Kubernetes Administrator',
        issuer: 'Cloud Native Computing Foundation (CNCF)',
        description:
            'Cluster architecture, workloads, services, networking, storage, '
            'and troubleshooting Kubernetes environments.',
        icon: Icons.hub,
      ),
    ];

    if (isMobile) {
      return Column(
        children: certs.asMap().entries.map((entry) {
          return ScrollReveal(
            delay: Duration(milliseconds: entry.key * 100),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CertCard(
                title: entry.value.title,
                issuer: entry.value.issuer,
                description: entry.value.description,
                icon: entry.value.icon,
                inProgress: entry.value.inProgress,
                credentialUrl: entry.value.credentialUrl,
              ),
            ),
          );
        }).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: certs.asMap().entries.map((entry) {
        return Expanded(
          child: ScrollReveal(
            delay: Duration(milliseconds: entry.key * 100),
            child: Padding(
              padding: EdgeInsets.only(
                left: entry.key == 0 ? 0 : 10,
                right: entry.key == certs.length - 1 ? 0 : 10,
              ),
              child: CertCard(
                title: entry.value.title,
                issuer: entry.value.issuer,
                description: entry.value.description,
                icon: entry.value.icon,
                inProgress: entry.value.inProgress,
                credentialUrl: entry.value.credentialUrl,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _Cert {
  final String title;
  final String issuer;
  final String description;
  final IconData icon;
  final bool inProgress;
  final String? credentialUrl;
  const _Cert({
    required this.title,
    required this.issuer,
    required this.description,
    required this.icon,
    this.inProgress = true,
    this.credentialUrl,
  });
}
