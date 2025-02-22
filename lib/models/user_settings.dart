class UserSettings {
  final bool soundEnabled;
  final bool musicEnabled;
  final int graphicsQuality; // 1: 低, 2: 中, 3: 高

  UserSettings({
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.graphicsQuality = 2,
  });

  Map<String, dynamic> toJson() => {
    'soundEnabled': soundEnabled,
    'musicEnabled': musicEnabled,
    'graphicsQuality': graphicsQuality,
  };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
    soundEnabled: json['soundEnabled'] ?? true,
    musicEnabled: json['musicEnabled'] ?? true,
    graphicsQuality: json['graphicsQuality'] ?? 2,
  );
}