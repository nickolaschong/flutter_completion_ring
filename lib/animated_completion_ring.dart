import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCompletionRing extends StatefulWidget {
  const AnimatedCompletionRing({Key? key}) : super(key: key);

  @override
  _AnimatedCompletionRingState createState() => _AnimatedCompletionRingState();
}

class _AnimatedCompletionRingState extends State<AnimatedCompletionRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curveAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _curveAnimation = _animationController.drive(
      CurveTween(
        curve: Curves.easeInOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CompletionRing extends StatelessWidget {
  const CompletionRing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
          baseColor: Colors.grey,
          fillColor: Colors.pink,
          value: 0.1,
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  /// * [baseColor] is unfilled color of the ring
  /// * [fillColor] is the fill color of the ring
  /// * [value] is the fill value that range from 0.0 to 1.0
  RingPainter({
    required this.baseColor,
    required this.fillColor,
    required this.value,
  });

  final Color baseColor;
  final Color fillColor;

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final basePaint = Paint()
      ..color = baseColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, basePaint);

    final fillPaint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * value,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.value != value;
}
