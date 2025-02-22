import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';
import '../models/ski_record.dart';
import '../utils/helpers.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('趋势分析')),
      body: FutureBuilder<List<SkiRecord>>(
        future: Provider.of<StorageService>(context).getRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('暂无滑雪记录'));
          }

          final records = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCard(records),
                const SizedBox(height: 20),
                _buildWeeklyChart(records),
                const SizedBox(height: 20),
                _buildEquipmentStats(records),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(List<SkiRecord> records) {
    final totalMinutes = records.fold<int>(
      0,
      (sum, record) => sum + record.durationMinutes,
    );
    final totalSessions = records.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '总览',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('总滑雪时间: $totalMinutes 分钟'),
            Text('总滑雪次数: $totalSessions 次'),
            Text('平均每次: ${(totalMinutes / totalSessions).toStringAsFixed(1)} 分钟'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(List<SkiRecord> records) {
    // 实现周统计图表
    return const SizedBox(height: 200);
  }

  Widget _buildEquipmentStats(List<SkiRecord> records) {
    final snowboardCount = records.where((r) => r.equipmentType == 'snowboard').length;
    final skiCount = records.where((r) => r.equipmentType == 'ski').length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '装备使用统计',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('单板滑雪: $snowboardCount 次'),
            Text('双板滑雪: $skiCount 次'),
          ],
        ),
      ),
    );
  }
}