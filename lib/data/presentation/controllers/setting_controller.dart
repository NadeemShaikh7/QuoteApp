import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../models/app_settings.dart';
import '../../repository/settings_repository.dart';

class SettingsController extends GetxController {

  final SettingsRepository _repo = SettingsRepository();
  final notificationTime =
      const TimeOfDay(hour: 9, minute: 0).obs;

  void updateNotificationTime(TimeOfDay time) {
    notificationTime(time);
  }

  final isDarkMode = false.obs;
  final fontScale = 1.0.obs;
  final accentIndex = 0.obs;

  final accentColors = const [
    0xFF6750A4, // Purple
    0xFF006D3C, // Green
    0xFF0B5ED7, // Blue
  ];

  @override
  void onInit() {
    _loadSettings();
    super.onInit();
  }

  Future<void> _loadSettings() async {
    // 1️⃣ Load local
    final local = await _repo.loadLocal();
    _apply(local);

    // 2️⃣ Override with cloud if exists
    final cloud = _repo.loadFromCloud();
    if (cloud != null) {
      _apply(cloud);
      await _repo.saveLocal(cloud);
    }
  }

  void _apply(AppSettings settings) {
    isDarkMode(settings.isDarkMode);
    fontScale(settings.fontScale);
    accentIndex(settings.accentIndex);
  }

  Future<void> _persist() async {
    final settings = AppSettings(
      isDarkMode: isDarkMode.value,
      fontScale: fontScale.value,
      accentIndex: accentIndex.value,
    );

    await _repo.saveLocal(settings);
    await _repo.syncToCloud(settings);
  }

  // ---------- Actions ----------
  void toggleTheme(bool value) {
    isDarkMode(value);
    _persist();
  }

  void updateFontScale(double value) {
    fontScale(value);
    _persist();
  }

  void updateAccent(int index) {
    accentIndex(index);
    _persist();
  }
}
