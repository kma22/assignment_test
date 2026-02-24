import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  AudioManager._() {
    final context = AudioContext(
      iOS: AudioContextIOS(category: AVAudioSessionCategory.ambient),
      android: AudioContextAndroid(audioFocus: AndroidAudioFocus.none),
    );
    _bgPlayer.setAudioContext(context);
    _sfxPlayer.setAudioContext(context);
  }
  static final AudioManager instance = AudioManager._();

  final AudioPlayer _bgPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _soundEnabled = true;
  bool get soundEnabled => _soundEnabled;

  double _volume = 0.5;
  double get volume => _volume;

  Future<void> playBackground() async {
    if (!_soundEnabled) return;
    await _bgPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgPlayer.setVolume(_volume * 0.4);
    await _bgPlayer.play(AssetSource('sounds/background.mp3'));
  }

  Future<void> playPress() async {
    if (!_soundEnabled) return;
    await _sfxPlayer.stop();
    await _sfxPlayer.setVolume(_volume);
    await _sfxPlayer.play(AssetSource('sounds/press.mp3'));
  }

  Future<void> playVictory() async {
    if (!_soundEnabled) return;
    await _sfxPlayer.setVolume(_volume);
    await _sfxPlayer.play(AssetSource('sounds/victory.mp3'));
  }

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    if (_soundEnabled) {
      playBackground();
    } else {
      _bgPlayer.stop();
      _sfxPlayer.stop();
    }
  }

  void setVolume(final double v) {
    _volume = v.clamp(0.0, 1.0);
    _bgPlayer.setVolume(_volume * 0.4);
  }

  Future<void> dispose() async {
    await _bgPlayer.dispose();
    await _sfxPlayer.dispose();
  }
}
