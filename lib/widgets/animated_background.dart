import 'dart:math';
import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _particles = [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (_particles.isNotEmpty) return;
    final count = (size.width * size.height / 15000).clamp(30, 80).toInt();
    _particles = List.generate(count, (_) {
      return _Particle(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        vx: (_random.nextDouble() - 0.5) * 0.4,
        vy: (_random.nextDouble() - 0.5) * 0.4,
        radius: _random.nextDouble() * 2 + 1,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initParticles(size);
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            _updateParticles(size);
            return CustomPaint(
              size: size,
              painter: _NetworkPainter(
                particles: _particles,
                accentColor: AppColors.accent,
              ),
            );
          },
        );
      },
    );
  }

  void _updateParticles(Size size) {
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;

      if (p.x < 0) {
        p.x = 0;
        p.vx = p.vx.abs();
      } else if (p.x > size.width) {
        p.x = size.width;
        p.vx = -p.vx.abs();
      }

      if (p.y < 0) {
        p.y = 0;
        p.vy = p.vy.abs();
      } else if (p.y > size.height) {
        p.y = size.height;
        p.vy = -p.vy.abs();
      }
    }
  }
}

class _Particle {
  double x, y, vx, vy, radius;
  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
  });
}

class _NetworkPainter extends CustomPainter {
  final List<_Particle> particles;
  final Color accentColor;
  static const double _connectionDistance = 150;

  _NetworkPainter({required this.particles, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..strokeWidth = 0.5;
    final dotPaint = Paint();

    // Draw connecting lines
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final dist = sqrt(dx * dx + dy * dy);

        if (dist < _connectionDistance) {
          final opacity = (1 - dist / _connectionDistance) * 0.15;
          linePaint.color = accentColor.withValues(alpha: opacity);
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }

    // Draw particles
    for (final p in particles) {
      dotPaint.color = accentColor.withValues(alpha: 0.3);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, dotPaint);

      // Subtle glow
      dotPaint.color = accentColor.withValues(alpha: 0.08);
      canvas.drawCircle(Offset(p.x, p.y), p.radius * 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NetworkPainter oldDelegate) => true;
}
