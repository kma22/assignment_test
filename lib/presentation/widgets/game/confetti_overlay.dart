import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiController extends ChangeNotifier {
  bool _playing = false;
  bool get playing => _playing;

  void play() {
    _playing = true;
    notifyListeners();
  }

  void stop() {
    _playing = false;
    notifyListeners();
  }
}

class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({required this.controller, super.key});

  final ConfettiController controller;

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    _animation.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (widget.controller.playing) {
      _particles = _generateParticles(80);
      _animation.forward(from: 0);
    } else {
      _animation.reset();
    }
  }

  List<_Particle> _generateParticles(final int count) {
    final random = Random();
    return List.generate(count, (_) {
      return _Particle(
        x: random.nextDouble(),
        startY: -0.1 - random.nextDouble() * 0.3,
        speed: 0.4 + random.nextDouble() * 0.6,
        size: 4 + random.nextDouble() * 6,
        rotation: random.nextDouble() * 2 * pi,
        rotationSpeed: (random.nextDouble() - 0.5) * 6,
        drift: (random.nextDouble() - 0.5) * 0.15,
        colorIndex: random.nextInt(_confettiColors.length),
      );
    });
  }

  static const _confettiColors = [
    Color(0xFF00E5FF),
    Color(0xFF76FF03),
    Color(0xFFFFD600),
    Color(0xFFFF4081),
    Color(0xFFAA00FF),
    Color(0xFFFF6E40),
  ];

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (final context, _) {
        if (!_animation.isAnimating && _animation.value == 0) {
          return const SizedBox.shrink();
        }
        return IgnorePointer(
          child: CustomPaint(
            size: Size.infinite,
            painter: _ConfettiPainter(
              particles: _particles,
              progress: _animation.value,
              colors: _confettiColors,
            ),
          ),
        );
      },
    );
  }
}

class _Particle {
  _Particle({
    required this.x,
    required this.startY,
    required this.speed,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
    required this.drift,
    required this.colorIndex,
  });

  final double x;
  final double startY;
  final double speed;
  final double size;
  final double rotation;
  final double rotationSpeed;
  final double drift;
  final int colorIndex;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({
    required this.particles,
    required this.progress,
    required this.colors,
  });

  final List<_Particle> particles;
  final double progress;
  final List<Color> colors;

  @override
  void paint(final Canvas canvas, final Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      final double t = progress * p.speed;
      final double x = (p.x + p.drift * progress) * size.width;
      final double y = (p.startY + t * 1.3) * size.height;

      if (y > size.height || y < -20) continue;

      final double opacity = progress < 0.8 ? 1.0 : (1.0 - progress) / 0.2;
      paint.color = colors[p.colorIndex].withValues(alpha: opacity.clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation + p.rotationSpeed * progress);

      final rect = Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6);
      canvas.drawRect(rect, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(final _ConfettiPainter old) => old.progress != progress;
}
