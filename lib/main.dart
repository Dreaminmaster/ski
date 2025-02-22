import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_pomodoro/services/storage_service.dart';
import 'package:ski_pomodoro/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = await StorageService.initialize();
  
  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>(create: (_) => storageService),
      ],
      child: const SkiPomodoroApp(),
    ),
  );
}

class SkiPomodoroApp extends StatelessWidget {
  const SkiPomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '滑雪番茄钟',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}