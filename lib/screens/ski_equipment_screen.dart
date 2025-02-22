import 'package:flutter/material.dart';
import '../screens/ski_preparation_screen.dart';

class SkiEquipmentScreen extends StatelessWidget {
  final int durationMinutes;

  const SkiEquipmentScreen({
    super.key,
    required this.durationMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选择滑雪装备')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildEquipmentChoice(
              context,
              '单板滑雪',
              'assets/images/snowboard.png',
              'snowboard',
            ),
            _buildEquipmentChoice(
              context,
              '双板滑雪',
              'assets/images/ski.png',
              'ski',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentChoice(
    BuildContext context,
    String title,
    String imagePath,
    String type,
  ) {
    return InkWell(
      onTap: () => _selectEquipment(context, type),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, height: 200),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  void _selectEquipment(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SkiPreparationScreen(
          durationMinutes: durationMinutes,
          equipmentType: type,
        ),
      ),
    );
  }
}