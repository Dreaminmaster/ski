import 'package:shared_preferences.dart';
import 'dart:convert';
import '../models/ski_record.dart';

class StorageService {
  final SharedPreferences _prefs;
  static const String _recordsKey = 'ski_records';

  StorageService._(this._prefs);

  static Future<StorageService> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService._(prefs);
  }

  Future<void> saveRecord(SkiRecord record) async {
    final records = await getRecords();
    records.add(record);
    final jsonList = records.map((r) => r.toJson()).toList();
    await _prefs.setString(_recordsKey, jsonEncode(jsonList));
  }

  Future<List<SkiRecord>> getRecords() async {
    final jsonString = _prefs.getString(_recordsKey);
    if (jsonString == null) return [];
    
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((json) => SkiRecord.fromJson(json)).toList();
  }
}