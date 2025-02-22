import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'ski_simulation_screen.dart';

class SkiPreparationScreen extends StatefulWidget {
  final int durationMinutes;
  final String equipmentType;

  const SkiPreparationScreen({
    super.key,
    required this.durationMinutes,
    required this.equipmentType,
  });

  @override
  State<SkiPreparationScreen> createState() => _SkiPreparationScreenState();
}

class _SkiPreparationScreenState extends State<SkiPreparationScreen> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _startPreparation();
  }

  void _startPreparation() async {
    for (var i = 0; i < AppConstants.preparationSteps.length; i++) {
      await Future.delayed(AppConstants.preparationDuration);
      if (mounted) {
        setState(() {
          _currentStep = i;
        });
      }
    }
    
    if (mounted) {
      await Future.delayed(AppConstants.preparationDuration);
      _navigateToSimulation();
    }
  }

  void _navigateToSimulation() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SkiSimulationScreen(
          durationMinutes: widget.durationMinutes,
          equipmentType: widget.equipmentType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            AppConstants.preparationSteps[_currentStep],
            key: ValueKey(_currentStep),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}