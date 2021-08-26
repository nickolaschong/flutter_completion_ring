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
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              CompletionRing(value: _curveAnimation.value),
              const Positioned.fill(
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: FittedBox(
                    child: Icon(Icons.android),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (!_animationController.isCompleted) {
      _animationController.forward();
    } else {
      _animationController.value = 0;
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!_animationController.isCompleted) {
      _animationController.reverse();
    }
  }
}

class CompletionRing extends StatelessWidget {
  const CompletionRing({
    Key? key,
    required this.value,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
          baseColor: Colors.grey,
          fillColor: Colors.pink,
          value: value,
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
