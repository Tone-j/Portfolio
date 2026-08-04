import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';

/// Floating guided assistant that introduces visitors to the portfolio
/// and can jump them to any section or open the CV.
class PortfolioAssistant extends StatefulWidget {
  final void Function(int sectionIndex) onNavigate;

  const PortfolioAssistant({super.key, required this.onNavigate});

  @override
  State<PortfolioAssistant> createState() => _PortfolioAssistantState();
}

class _Message {
  final bool isBot;
  final String text;
  final int? navIndex;
  final String? navLabel;
  const _Message({
    required this.isBot,
    required this.text,
    this.navIndex,
    this.navLabel,
  });
}

class _Topic {
  final String emoji;
  final String label;
  final String response;
  final int? navIndex;
  final String? navLabel;
  final bool isDownload;
  const _Topic({
    required this.emoji,
    required this.label,
    required this.response,
    this.navIndex,
    this.navLabel,
    this.isDownload = false,
  });
}

class _PortfolioAssistantState extends State<PortfolioAssistant>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _hasSeenIntro = false;
  bool _showGreeting = false;
  bool _isTyping = false;
  final List<_Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late AnimationController _pulseController;

  static const String _cvFileName = 'Mongezi_Tone_Jali_Resume.pdf';

  late final List<_Topic> _topics = [
    const _Topic(
      emoji: '👋',
      label: 'Quick Summary',
      response:
          "Hi, I'm Tone. I'm a backend and cloud engineer who enjoys building production systems that stay reliable under real-world conditions. Over the past three years at OOGi Labs I've worked across AI, IoT, cloud infrastructure, and mobile platforms—designing .NET services, Azure workloads, observability stacks, and deployment pipelines. My current focus is Platform Engineering, DevOps, and building scalable cloud infrastructure. ",
      // "cloud-based AI & IoT platforms at OOGi Labs, now transitioning into "
      // "DevOps, Platform Engineering, and SRE. I work across .NET Core, Azure, "
      // "Flutter, and monitoring stacks like Prometheus & Grafana.",
      navIndex: 1,
      navLabel: 'See About ↓',
    ),
    const _Topic(
      emoji: '💼',
      label: 'Experience',
      response:
          "• I've spent the last three years building production software rather than tutorial projects. My work includes cloud-native APIs, Azure Functions, Docker deployments, AI camera integrations, observability platforms with Prometheus and Grafana, billing system integrations, and Flutter applications used by operational teams. Working in a startup has allowed me to take ownership across the full software lifecycle—from design and implementation to deployment, monitoring, and production support.",
      navIndex: 5,
      navLabel: 'See full timeline ↓',
    ),
    const _Topic(
      emoji: '🛠️',
      label: 'Skills',
      response:
          "My strongest skills are backend engineering and cloud infrastructure. I build APIs with ASP.NET Core, deploy workloads to Azure, containerize services with Docker, and monitor production systems using Prometheus and Grafana. I also develop Flutter applications and enjoy improving developer experience through automation and CI/CD practices. Rather than collecting technologies, I focus on understanding how they work together to build reliable systems.",
      navIndex: 2,
      navLabel: 'See all skills ↓',
    ),
    const _Topic(
      emoji: '🚀',
      label: 'Projects',
      response:
          "• My projects reflect the kinds of engineering problems I enjoy solving. They include an AI-enabled fleet management platform, a cloud-based taxi advertising SaaS application, a production monitoring stack with Prometheus and Grafana, Firebase messaging infrastructure, and real-time IoT camera streaming services. Each project emphasizes scalability, observability, and maintainability rather than simply demonstrating the use of a framework.",
      navIndex: 3,
      navLabel: 'See all projects ↓',
    ),
    const _Topic(
      emoji: '📜',
      label: 'Certifications',
      response:
          "• I'm committed to building deep cloud engineering expertise. After completing Microsoft Azure Fundamentals (AZ-900), I'm working toward Azure Administrator (AZ-104) and Certified Kubernetes Administrator (CKA). These complement my hands-on experience designing and operating cloud applications.",
      navIndex: 4,
      navLabel: 'See certifications ↓',
    ),
    const _Topic(
      emoji: '📬',
      label: 'Contact',
      response:
          "I'm based in Durban, South Africa, and I'm open to startup, hybrid, remote, or on-site opportunities where I can contribute to backend engineering, cloud infrastructure, DevOps, or Platform Engineering. If you're building products that value reliability, scalability, and ownership, I'd be delighted to connect.",
      navIndex: 6,
      navLabel: 'Jump to contact ↓',
    ),
    const _Topic(
      emoji: '📄',
      label: 'Download CV',
      response: "Here's my CV — I've opened it in a new tab. 📄",
      isDownload: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _messages.add(const _Message(
      isBot: true,
      text: "👋 Hi, I'm Tone's assistant! Want to know more about him? "
          "Pick a topic below.",
    ));

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_isOpen && !_hasSeenIntro) {
        setState(() => _showGreeting = true);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleTopicTap(_Topic topic) {
    if (topic.isDownload) {
      launchUrl(Uri.parse(_cvFileName));
    }

    setState(() {
      _messages
          .add(_Message(isBot: false, text: '${topic.emoji} ${topic.label}'));
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_Message(
          isBot: true,
          text: topic.response,
          navIndex: topic.navIndex,
          navLabel: topic.navLabel,
        ));
      });
      _scrollToBottom();
    });
  }

  void _navigateTo(int index) {
    setState(() => _isOpen = false);
    widget.onNavigate(index);
  }

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
      _hasSeenIntro = true;
      _showGreeting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final panelWidth = isMobile ? size.width - 32 : 360.0;
    final panelHeight = (size.height - 220).clamp(320.0, 480.0);

    return Positioned.fill(
      child: Stack(
        children: [
          if (_isOpen)
            Positioned(
              bottom: 168,
              right: isMobile ? 16 : 24,
              child: _ChatPanel(
                width: panelWidth,
                height: panelHeight,
                messages: _messages,
                topics: _topics,
                isTyping: _isTyping,
                scrollController: _scrollController,
                onTopicTap: _handleTopicTap,
                onNavigate: _navigateTo,
                onClose: () => setState(() => _isOpen = false),
              ),
            ),
          if (_showGreeting)
            Positioned(
              bottom: 160,
              right: isMobile ? 16 : 24,
              child: _GreetingBubble(
                onTap: _toggleOpen,
                onDismiss: () => setState(() => _showGreeting = false),
              ),
            ),
          Positioned(
            bottom: 96,
            right: isMobile ? 16 : 24,
            child: _AssistantFab(
              isOpen: _isOpen,
              showBadge: !_hasSeenIntro,
              pulseController: _pulseController,
              onTap: _toggleOpen,
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingBubble extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _GreetingBubble({required this.onTap, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 220),
          padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "👋 Hi! Want to know more about me?",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDismiss,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child:
                      Icon(Icons.close, size: 14, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssistantFab extends StatelessWidget {
  final bool isOpen;
  final bool showBadge;
  final AnimationController pulseController;
  final VoidCallback onTap;

  const _AssistantFab({
    required this.isOpen,
    required this.showBadge,
    required this.pulseController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: pulseController,
                builder: (context, child) {
                  final scale = 1.0 + (pulseController.value * 0.35);
                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: (1 - pulseController.value) * 0.4,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: isOpen
                    ? Icon(
                        Icons.close,
                        color: AppColors.background,
                        size: 26,
                      )
                    : ClipOval(
                        child: Image.network(
                          'icons/my_avator.png',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              if (showBadge && !isOpen)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatPanel extends StatelessWidget {
  final double width;
  final double height;
  final List<_Message> messages;
  final List<_Topic> topics;
  final bool isTyping;
  final ScrollController scrollController;
  final void Function(_Topic) onTopicTap;
  final void Function(int) onNavigate;
  final VoidCallback onClose;

  const _ChatPanel({
    required this.width,
    required this.height,
    required this.messages,
    required this.topics,
    required this.isTyping,
    required this.scrollController,
    required this.onTopicTap,
    required this.onNavigate,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= messages.length) {
                  return const _TypingBubble();
                }
                final message = messages[index];
                return _MessageBubble(
                  message: message,
                  onNavigate: onNavigate,
                );
              },
            ),
          ),
          _buildTopicChips(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'icons/my_avator.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tone's Assistant",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style:
                          TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, color: AppColors.textMuted, size: 18),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildTopicChips() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: topics
            .map((topic) =>
                _TopicChip(topic: topic, onTap: () => onTopicTap(topic)))
            .toList(),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _Message message;
  final void Function(int) onNavigate;

  const _MessageBubble({required this.message, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isBot = message.isBot;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 260),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isBot
                  ? AppColors.surface
                  : AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: isBot ? Border.all(color: AppColors.cardBorder) : null,
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isBot ? AppColors.textSecondary : AppColors.accent,
              ),
            ),
          ),
          if (message.navIndex != null) ...[
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => onNavigate(message.navIndex!),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  message.navLabel ?? 'See more ↓',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.accent,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Text(
            '···',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class _TopicChip extends StatefulWidget {
  final _Topic topic;
  final VoidCallback onTap;

  const _TopicChip({required this.topic, required this.onTap});

  @override
  State<_TopicChip> createState() => _TopicChipState();
}

class _TopicChipState extends State<_TopicChip> {
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
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.15)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.cardBorder,
            ),
          ),
          child: Text(
            '${widget.topic.emoji} ${widget.topic.label}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _isHovered ? AppColors.accent : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
