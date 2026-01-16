class AppSettings {
  final bool isDarkMode;
  final double fontScale;
  final int accentIndex;

  AppSettings({
    required this.isDarkMode,
    required this.fontScale,
    required this.accentIndex,
  });

  factory AppSettings.defaultSettings() {
    return AppSettings(
      isDarkMode: false,
      fontScale: 1.0,
      accentIndex: 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_dark_mode': isDarkMode,
    'font_scale': fontScale,
    'accent_index': accentIndex,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isDarkMode: json['is_dark_mode'] ?? false,
      fontScale:
      (json['font_scale'] ?? 1.0).toDouble(),
      accentIndex: json['accent_index'] ?? 0,
    );
  }
}
