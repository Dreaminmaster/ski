import 'package:flutter/material.dart';
import 'dart:async';
import '../services/audio_service.dart';
import '../widgets/ski_animation_widget.dart';
import 'ski_completion_screen.dart';

class SkiSimulationScreen extends StatefulWidget {
  final int durationMinutes;
  final String equipmentType;

  const SkiSimulationScreen({
    super.key,
    required this.durationMinutes,
    required this.equipmentType,
  });

  @override
  State<SkiSimulationScreen> createState() => _SkiSimulationScreenState();
}

class _SkiSimulationScreenState extends State<SkiSimulationScreen> {
  late Timer _timer;
  late int _remainingSeconds;
  final AudioService _audioService = AudioService();
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        _onComplete();
      }
    });
  }

  void _onComplete() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SkiCompletionScreen(
          durationMinutes: widget.durationMinutes,
          equipmentType: widget.equipmentType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SkiAnimationWidget(),
          Positioned(
            top: 40,
            left: 20,
            child: Text(
              '${_remainingSeconds ~/ 60}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
              onPressed: _togglePause,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _timer.cancel();
      } else {
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioService.dispose();
    super.dispose();
  }
}