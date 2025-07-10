import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class AnimatedCircularProgress extends StatefulWidget {
  final double percent; // Initial percent (won't stay fixed)
  final double size;
  final Color fillColor;
  final Color bgColor;
  final Color borderColor;
  final Duration duration;

  const AnimatedCircularProgress({
    super.key,
    required this.percent,
    this.size = 140,
    this.fillColor = const Color(0xFF4BA3E6),
    this.bgColor = const Color(0xFFEAEAEA),
    this.borderColor = Colors.black,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<AnimatedCircularProgress> createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentPercent = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentPercent = widget.percent;
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: _currentPercent)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _animateToRandom());
  }

  void _animateToRandom() {
    final random = Random();
    double newPercent = (random.nextDouble() * 0.7) + 0.3; // 0.3 to 1.0

    _controller.dispose(); // Dispose the old controller before making a new one!
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: _currentPercent, end: newPercent)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    setState(() {
      _currentPercent = newPercent;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircleProgressPainter(
              percent: _animation.value,
              fillColor: widget.fillColor,
              bgColor: widget.bgColor,
              borderColor: widget.borderColor,
              strokeWidth: 16,
              borderWidth: 2.5,
            ),
            child: Center(
              child: Text(
                '${(_animation.value * 100).round()}%',
                style: TextStyle(
                  fontSize: widget.size * 0.25,
                  color: widget.fillColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color bgColor;
  final Color borderColor;
  final double strokeWidth;
  final double borderWidth;

  _CircleProgressPainter({
    required this.percent,
    required this.fillColor,
    required this.bgColor,
    required this.borderColor,
    required this.strokeWidth,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width / 2) - borderWidth;

    // Draw border
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawCircle(center, radius + strokeWidth / 2, borderPaint);

    // Draw background circle
    final Paint bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw progress arc
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    double sweepAngle = 2 * pi * percent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) => percent != oldDelegate.percent;
}
