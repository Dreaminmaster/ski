class SkiRecord {
  final DateTime timestamp;
  final int durationMinutes;
  final String equipmentType;
  final bool completed;

  SkiRecord({
    required this.timestamp,
    required this.durationMinutes,
    required this.equipmentType,
    this.completed = true,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'durationMinutes': durationMinutes,
    'equipmentType': equipmentType,
    'completed': completed,
  };

  factory SkiRecord.fromJson(Map<String, dynamic> json) => SkiRecord(
    timestamp: DateTime.parse(json['timestamp']),
    durationMinutes: json['durationMinutes'],
    equipmentType: json['equipmentType'],
    completed: json['completed'],
  );
}