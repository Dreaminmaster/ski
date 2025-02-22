import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';
import '../models/ski_record.dart';
import 'home_screen.dart';

class SkiCompletionScreen extends StatelessWidget {
  final int durationMinutes;
  final String equipmentType;

  const SkiCompletionScreen({
    super.key,
    required this.durationMinutes,
    required this.equipmentType,
  });

  @override
  Widget build(BuildContext context) {
    _saveRecord(context);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                '完成滑雪！',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '持续时间: $durationMinutes 分钟',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _returnToHome(context),
                child: const Text('返回主页'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveRecord(BuildContext context) async {
    final storage = Provider.of<StorageService>(context, listen: false);
    final record = SkiRecord(
      timestamp: DateTime.now(),
      durationMinutes: durationMinutes,
      equipmentType: equipmentType,
    );
    await storage.saveRecord(record);
  }

  void _returnToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
}