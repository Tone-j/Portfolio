import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                  'Skills & Technologies',
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
                  'Technologies I work with across the full stack and DevOps lifecycle',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          ..._buildCategories(context, isMobile),
        ],
      ),
    );
  }

  List<Widget> _buildCategories(BuildContext context, bool isMobile) {
    final categories = [
      _SkillCategory(
        'Cloud & Infrastructure',
        Icons.cloud_outlined,
        [
          _Skill(Icons.cloud, 'Azure Functions'),
          _Skill(Icons.dns, 'App Services'),
          _Skill(Icons.storage, 'Cosmos DB'),
          _Skill(Icons.inventory_2, 'Blob Storage'),
          _Skill(Icons.local_fire_department, 'Firebase'),
          _Skill(Icons.terminal, 'Linux'),
        ],
      ),
      _SkillCategory(
        'DevOps & CI/CD',
        Icons.settings_suggest_outlined,
        [
          _Skill(FontAwesomeIcons.docker, 'Docker'),
          _Skill(Icons.hub, 'Kubernetes'),
          _Skill(Icons.account_tree, 'Azure DevOps'),
          _Skill(FontAwesomeIcons.github, 'GitHub Actions'),
          _Skill(FontAwesomeIcons.gitlab, 'GitLab CI'),
          _Skill(Icons.build_circle, 'Jenkins'),
        ],
      ),
      _SkillCategory(
        'Monitoring & Observability',
        Icons.monitor_heart_outlined,
        [
          _Skill(Icons.show_chart, 'Prometheus'),
          _Skill(Icons.dashboard, 'Grafana'),
          _Skill(Icons.notifications_active, 'Alertmanager'),
          _Skill(Icons.search, 'Elasticsearch'),
        ],
      ),
      _SkillCategory(
        'Backend Development',
        Icons.code,
        [
          _Skill(Icons.code, 'C# / .NET Core'),
          _Skill(Icons.api, 'ASP.NET Web API'),
          _Skill(Icons.table_chart, 'SQL Server'),
          _Skill(Icons.layers, 'Entity Framework'),
          _Skill(FontAwesomeIcons.python, 'Python'),
          _Skill(FontAwesomeIcons.java, 'Java'),
        ],
      ),
      _SkillCategory(
        'Frontend & Mobile',
        Icons.phone_android,
        [
          _Skill(Icons.flutter_dash, 'Flutter'),
          _Skill(Icons.code, 'Dart'),
          _Skill(Icons.web, 'HTML / CSS'),
          _Skill(FontAwesomeIcons.js, 'JavaScript'),
        ],
      ),
      _SkillCategory(
        'Practices & Tools',
        Icons.handyman,
        [
          _Skill(Icons.loop, 'Agile / Scrum'),
          _Skill(Icons.bug_report, 'TDD'),
          _Skill(Icons.architecture, 'API Design'),
          _Skill(Icons.integration_instructions, 'System Integration'),
          _Skill(Icons.science, 'Postman'),
          _Skill(FontAwesomeIcons.git, 'Git'),
          _Skill(FontAwesomeIcons.figma, 'Figma'),
          _Skill(FontAwesomeIcons.jira, 'Jira'),
        ],
      ),
    ];

    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      final crossAxisCount = isMobile ? 2 : (MediaQuery.of(context).size.width > 1200 ? 5 : 3);

      return ScrollReveal(
        delay: Duration(milliseconds: index * 100),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(category.icon, color: AppColors.accent, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    category.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: category.skills
                    .map((skill) => SkillCard(
                          icon: skill.icon,
                          label: skill.label,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

class _SkillCategory {
  final String title;
  final IconData icon;
  final List<_Skill> skills;
  const _SkillCategory(this.title, this.icon, this.skills);
}

class _Skill {
  final IconData icon;
  final String label;
  const _Skill(this.icon, this.label);
}
