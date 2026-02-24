import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pipes/domain/audio_manager.dart';
import 'package:pipes/domain/models/difficulty.dart';
import 'package:pipes/presentation/screens/game_screen.dart';
import 'package:pipes/presentation/widgets/home/logo.dart';
import 'package:pipes/presentation/widgets/home/settings_controls.dart';
import 'package:pipes/presentation/widgets/home/start_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AudioManager.instance.playBackground();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: SettingsControls(),
            ),
            const Spacer(flex: 3),
            const Logo(),
            const Spacer(flex: 5),
            StartButtons(onPressed: _start),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  FutureOr<void> _start(final Difficulty difficulty) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GameScreen(size: difficulty.size),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
