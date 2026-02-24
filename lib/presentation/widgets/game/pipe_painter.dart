import 'package:flutter/material.dart';
import 'package:pipes/domain/models/pipe.dart';
import 'package:pipes/domain/models/side.dart';
import 'package:pipes/presentation/theme/app_colors.dart';

class PipePainter extends CustomPainter {
  PipePainter({required this.pipe});

  final Pipe pipe;

  @override
  void paint(final Canvas canvas, final Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = pipe.isActivated ? AppColors.pipeActive : AppColors.pipeInactive
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Draw lines
    for (var side in pipe.currentConnections) {
      final endpoint = switch (side) {
        Side.top => Offset(size.width / 2, 0),
        Side.right => Offset(size.width, size.height / 2),
        Side.bottom => Offset(size.width / 2, size.height),
        Side.left => Offset(0, size.height / 2),
      };
      canvas.drawLine(center, endpoint, paint);
    }

    // Draw specific markers based on sealed type
    switch (pipe) {
      case StarterPipe():
        canvas.drawCircle(center, 8, paint..color = AppColors.starter);
        canvas.drawCircle(center, 3, Paint()..color = AppColors.white);
      case TerminatorPipe():
        canvas.drawCircle(
          center,
          7,
          paint
            ..color =
                pipe.isActivated ? AppColors.terminatorActive : AppColors.terminatorInactive,
        );
      case MiddlePipe():
        canvas.drawCircle(center, 2, paint);
    }
  }

  @override
  bool shouldRepaint(final PipePainter old) => old.pipe != pipe;
}
