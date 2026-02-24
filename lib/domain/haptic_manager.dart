import 'package:flutter/services.dart';

class HapticManager {
  HapticManager._();
  static final HapticManager instance = HapticManager._();

  bool _enabled = true;
  bool get enabled => _enabled;

  void toggle() {
    _enabled = !_enabled;
  }

  void light() {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
  }

  void heavy() {
    if (!_enabled) return;
    HapticFeedback.heavyImpact();
  }
}
