import 'package:flutter/material.dart';

class SkiAnimationWidget extends StatefulWidget {
  const SkiAnimationWidget({super.key});

  @override
  State<SkiAnimationWidget> createState() => _SkiAnimationWidgetState();
}

class _SkiAnimationWidgetState extends State<SkiAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _horizontalPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _horizontalPosition += details.delta.dx;
          _horizontalPosition = _horizontalPosition.clamp(
            -50.0,
            50.0,
          );
        });
      },
      child: Container(
        color: Colors.lightBlue[100],
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: SkiTrailPainter(
                position: _horizontalPosition,
                animation: _controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SkiTrailPainter extends CustomPainter {
  final double position;
  final double animation;

  SkiTrailPainter({
    required this.position,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 实现滑雪轨迹的绘制逻辑
  }

  @override
  bool shouldRepaint(SkiTrailPainter oldDelegate) =>
      position != oldDelegate.position || animation != oldDelegate.animation;
}