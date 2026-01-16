import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  static const _localKey = 'app_settings';
  final SupabaseClient _client = Supabase.instance.client;

  // ---------- Local ----------
  Future<void> saveLocal(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _localKey,
      jsonEncode(settings.toJson()),
    );
  }

  Future<AppSettings> loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_localKey);

    if (raw == null) {
      return AppSettings.defaultSettings();
    }

    return AppSettings.fromJson(jsonDecode(raw));
  }

  // ---------- Cloud ----------
  Future<void> syncToCloud(AppSettings settings) async {
    await _client.auth.updateUser(
      UserAttributes(
        data: {
          'settings': settings.toJson(),
        },
      ),
    );
  }

  AppSettings? loadFromCloud() {
    final user = _client.auth.currentUser;
    final data = user?.userMetadata?['settings'];

    if (data == null) return null;
    return AppSettings.fromJson(
      Map<String, dynamic>.from(data),
    );
  }
}
