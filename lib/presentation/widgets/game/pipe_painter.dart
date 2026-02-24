import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:pipes/domain/models/pipe.dart';
import 'package:pipes/domain/models/side.dart';
import 'package:pipes/presentation/theme/app_colors_theme.dart';

class PipePainter extends CustomPainter {
  PipePainter({required this.pipe, required this.colors});

  final Pipe pipe;
  final AppColorsTheme colors;

  @override
  void paint(final Canvas canvas, final Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final bool active = pipe.isActivated;
    final double strokeW = size.width * 0.1;

    // Glow behind active pipes
    if (active) {
      final glowPaint = Paint()
        ..strokeWidth = strokeW * 2.5
        ..strokeCap = StrokeCap.round
        ..color = colors.pipeActive.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      for (var side in pipe.initialConnections) {
        canvas.drawLine(center, _endpointFor(side, size), glowPaint);
      }
    }

    // Pipe lines
    final linePaint = Paint()
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (active) {
      linePaint.shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [colors.pipeActive, colors.pipeActive.withValues(alpha: 0.7)],
      );
    } else {
      linePaint.color = colors.pipeInactive;
    }

    for (var side in pipe.initialConnections) {
      canvas.drawLine(center, _endpointFor(side, size), linePaint);
    }

    // Center node based on pipe type
    switch (pipe) {
      case StarterPipe():
        if (active) {
          canvas.drawCircle(
            center,
            size.width * 0.18,
            Paint()
              ..color = colors.starter.withValues(alpha: 0.25)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
          );
        }
        canvas.drawCircle(center, size.width * 0.14, Paint()..color = colors.starter);
        canvas.drawCircle(center, size.width * 0.06, Paint()..color = colors.highlight);
      case TerminatorPipe():
        final Color lampColor = active ? colors.terminatorActive : colors.terminatorInactive;
        if (active) {
          canvas.drawCircle(
            center,
            size.width * 0.16,
            Paint()
              ..color = colors.terminatorActive.withValues(alpha: 0.3)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
          );
        }
        canvas.drawCircle(center, size.width * 0.12, Paint()..color = lampColor);
        if (active) {
          canvas.drawCircle(
            center,
            size.width * 0.05,
            Paint()..color = colors.highlight.withValues(alpha: 0.8),
          );
        }
      case MiddlePipe():
        canvas.drawCircle(
          center,
          size.width * 0.04,
          Paint()..color = active ? colors.pipeActive : colors.pipeInactive,
        );
    }
  }

  Offset _endpointFor(final Side side, final Size size) => switch (side) {
    Side.top => Offset(size.width / 2, 0),
    Side.right => Offset(size.width, size.height / 2),
    Side.bottom => Offset(size.width / 2, size.height),
    Side.left => Offset(0, size.height / 2),
  };

  @override
  bool shouldRepaint(final PipePainter old) => old.pipe != pipe || old.colors != colors;
}
