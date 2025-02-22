import 'package:flutter/material.dart';

class SkiMapWidget extends StatelessWidget {
  final Function(String) onLocationSelected;

  const SkiMapWidget({
    super.key,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20.0),
      minScale: 0.5,
      maxScale: 2.0,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/ski_map.png',
            fit: BoxFit.cover,
          ),
          _buildLocationMarker(
            '初级道', 
            const Offset(0.3, 0.3), 
            Colors.green,
          ),
          _buildLocationMarker(
            '中级道', 
            const Offset(0.5, 0.5), 
            Colors.blue,
          ),
          _buildLocationMarker(
            '高级道', 
            const Offset(0.7, 0.7), 
            Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMarker(String name, Offset position, Color color) {
    return Positioned(
      left: position.dx * 100,
      top: position.dy * 100,
      child: GestureDetector(
        onTap: () => onLocationSelected(name),
        child: Column(
          children: [
            Icon(Icons.location_on, color: color, size: 30),
            Text(
              name,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}