import 'package:flutter/material.dart';
import 'package:pipes/domain/board_controller.dart';
import 'package:pipes/domain/models/pipe.dart';
import 'package:pipes/presentation/theme/app_colors_theme.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    required this.controller,
    super.key,
  });

  final BoardController controller;

  @override
  Widget build(final BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsTheme>()!;
    return SizedBox(
      height: kToolbarHeight * 2,
      child: ValueListenableBuilder<List<Pipe>>(
        valueListenable: controller,
        builder: (final context, final grid, _) {
          final bool isVictory = controller.isVictory;
          final int score = controller.score;

          if (isVictory) {
            return Center(
              child: Text(
                'Victory! Score: $score',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: colors.secondary,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Score: $score',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: colors.onSurface,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
