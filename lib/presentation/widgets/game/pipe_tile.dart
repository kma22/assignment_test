// ignore_for_file: always_put_required_named_parameters_first

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pipes/domain/board_controller.dart';
import 'package:pipes/domain/models/pipe.dart';
import 'package:pipes/presentation/widgets/game/pipe_painter.dart';

class PipeTile extends StatefulWidget {
  const PipeTile({
    super.key,
    required this.controller,
    required this.index,
    required this.onPressed,
  });

  final BoardController controller;
  final int index;
  final void Function() onPressed;

  @override
  State<PipeTile> createState() => _PipeTileState();
}

class _PipeTileState extends State<PipeTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _rotationAnimation;
  int _previousTurns = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    final pipe = widget.controller.value[widget.index];
    _previousTurns = pipe.turns;
    _rotationAnimation = AlwaysStoppedAnimation(pipe.turns * (pi / 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    widget.onPressed();
  }

  void _animateRotation(final int newTurns) {
    final double begin = _previousTurns * (pi / 2);
    final double end = newTurns * (pi / 2);
    _previousTurns = newTurns;

    _rotationAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward(from: 0);
  }

  @override
  Widget build(final BuildContext context) {
    return ValueListenableBuilder<List<Pipe>>(
      valueListenable: widget.controller,
      builder: (final context, final grid, _) {
        final Pipe pipe = grid[widget.index];

        if (pipe.turns != _previousTurns) {
          _animateRotation(pipe.turns);
        }

        return GestureDetector(
          onTap: _onTap,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (final context, final child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: child,
              );
            },
            child: CustomPaint(
              painter: PipePainter(pipe: pipe),
            ),
          ),
        );
      },
    );
  }
}
