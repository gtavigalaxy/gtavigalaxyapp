import 'dart:math';
import 'package:flutter/material.dart';

/// Twinkling starfield background with a tap-triggered star burst.
class Starfield extends StatefulWidget {
  final Widget child;
  final int starCount;

  const Starfield({super.key, required this.child, this.starCount = 90});

  @override
  State<Starfield> createState() => StarfieldState();
}

class StarfieldState extends State<Starfield>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Star> _stars;
  late List<_BurstParticle> _burst;
  final Random _random = Random();
  bool _bursting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _stars = List.generate(
      widget.starCount,
      (_) => _Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 0.6 + _random.nextDouble() * 1.8,
        phase: _random.nextDouble() * 2 * pi,
        speed: 0.5 + _random.nextDouble() * 1.5,
      ),
    );
    _burst = [];
  }

  /// Trigger a star burst from the center for a few seconds.
  void burst() {
    if (_bursting) return;
    _bursting = true;
    setState(() {
      _burst = List.generate(
        70,
        (_) {
          final angle = _random.nextDouble() * 2 * pi;
          final speed = 0.15 + _random.nextDouble() * 0.5;
          return _BurstParticle(
            angle: angle,
            speed: speed,
            size: 1.5 + _random.nextDouble() * 2.5,
            life: 0.0,
            maxLife: 1.5 + _random.nextDouble() * 1.5,
            color: _random.nextBool()
                ? const Color(0xFFFF2D78)
                : const Color(0xFF9D4EDD),
          );
        },
      );
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _bursting = false;
          _burst = [];
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: burst,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => CustomPaint(
                painter: _StarfieldPainter(
                  stars: _stars,
                  burst: _burst,
                  time: _controller.value * 3,
                  bursting: _bursting,
                ),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _Star {
  final double x, y, size, phase, speed;
  _Star(
      {required this.x,
      required this.y,
      required this.size,
      required this.phase,
      required this.speed});
}

class _BurstParticle {
  final double angle, speed, size, maxLife;
  final Color color;
  double life;
  _BurstParticle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.life,
    required this.maxLife,
    required this.color,
  });
}

class _StarfieldPainter extends CustomPainter {
  final List<_Star> stars;
  final List<_BurstParticle> burst;
  final double time;
  final bool bursting;

  _StarfieldPainter({
    required this.stars,
    required this.burst,
    required this.time,
    required this.bursting,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Twinkling background stars.
    for (final star in stars) {
      final twinkle =
          0.35 + 0.65 * (0.5 + 0.5 * sin(time * star.speed + star.phase));
      paint.color = Colors.white.withValues(alpha: twinkle * 0.7);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }

    // Burst particles expanding from the center.
    if (bursting) {
      final center = Offset(size.width / 2, size.height * 0.35);
      final maxDist = size.width * 0.7;
      for (final p in burst) {
        p.life += 0.016;
        final t = (p.life / p.maxLife).clamp(0.0, 1.0);
        if (t >= 1.0) continue;
        final dist = maxDist * p.speed * t;
        final pos = center +
            Offset(cos(p.angle) * dist, sin(p.angle) * dist);
        paint.color = p.color.withValues(alpha: (1 - t) * 0.9);
        canvas.drawCircle(pos, p.size * (1 - t * 0.5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
