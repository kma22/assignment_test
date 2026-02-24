import 'package:flutter/material.dart';
import 'package:pipes/domain/audio_manager.dart';
import 'package:pipes/domain/haptic_manager.dart';

class SettingsControls extends StatefulWidget {
  const SettingsControls({super.key});

  @override
  State<SettingsControls> createState() => _SettingsControlsState();
}

class _SettingsControlsState extends State<SettingsControls> {
  final AudioManager _audio = AudioManager.instance;
  final HapticManager _haptic = HapticManager.instance;
  bool _showVolumeSlider = false;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            setState(() => _audio.toggleSound());
          },
          icon: Icon(
            _audio.soundEnabled ? Icons.volume_up : Icons.volume_off,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() => _haptic.toggle());
          },
          icon: Icon(
            _haptic.enabled ? Icons.vibration : Icons.mobile_off,
            size: 28,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_showVolumeSlider)
              SizedBox(
                width: 140,
                child: Slider(
                  value: _audio.volume,
                  onChanged: (final v) {
                    setState(() => _audio.setVolume(v));
                  },
                ),
              ),
            IconButton(
              onPressed: () {
                setState(() => _showVolumeSlider = !_showVolumeSlider);
              },
              icon: const Icon(Icons.tune, size: 22),
            ),
          ],
        ),
      ],
    );
  }
}
