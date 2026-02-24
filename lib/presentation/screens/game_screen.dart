import 'package:flutter/material.dart';
import 'package:pipes/domain/audio_manager.dart';
import 'package:pipes/domain/board_controller.dart';
import 'package:pipes/domain/haptic_manager.dart';
import 'package:pipes/domain/models/pipe.dart';
import 'package:pipes/presentation/widgets/game/confetti_overlay.dart';
import 'package:pipes/presentation/widgets/game/pipe_tile.dart';
import 'package:pipes/presentation/widgets/game/status_bar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    required this.size,
    super.key,
  });

  final int size;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final BoardController controller = BoardController();
  final _confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.generateBoard(widget.size);
    controller.addListener(_checkVictory);
  }

  @override
  void dispose() {
    controller.removeListener(_checkVictory);
    _confettiController.dispose();
    super.dispose();
  }

  void _checkVictory() {
    if (controller.isVictory) {
      AudioManager.instance.playVictory();
      HapticManager.instance.heavy();
      _confettiController.play();
    }
  }

  void _onPipeTap(final int index) {
    controller.handleTap(index);
    AudioManager.instance.playPress();
    HapticManager.instance.light();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logopotam Assignment'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<List<Pipe>>(
            valueListenable: controller,
            builder: (final context, final grid, _) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatusBar(
                      controller: controller,
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: controller.size,
                            ),
                            itemCount: grid.length,
                            itemBuilder: (final context, final index) {
                              return PipeTile(
                                controller: controller,
                                index: index,
                                onPressed: () => _onPipeTap(index),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        _confettiController.stop();
                        controller.generateBoard(widget.size);
                      },
                      child: const Text('New Game'),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
          ConfettiOverlay(controller: _confettiController),
        ],
      ),
    );
  }
}
