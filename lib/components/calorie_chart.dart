import 'package:flutter/material.dart';
import 'dart:math';

class CalorieChart extends StatelessWidget {
  final double totalCalories;       // e.g. 568.1
  final double goalCalories;        // e.g. 1200
  final double carbsPercent;        // e.g. 50
  final double proteinPercent;      // e.g. 40
  final double fatsPercent;         // e.g. 10

  const CalorieChart({
    super.key,
    required this.totalCalories,
    required this.goalCalories,
    required this.carbsPercent,
    required this.proteinPercent,
    required this.fatsPercent,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (totalCalories / goalCalories).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🟢 Your macros are on track',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            'Keep it going 🔥',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CustomPaint(
                painter: CircleProgressPainter(progress: progress),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text(
                      "${totalCalories.toStringAsFixed(0)}\nKCal",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🥗 Calories Consumed',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    '${totalCalories.toStringAsFixed(1)} / ${goalCalories.toStringAsFixed(0)} KCal',
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildMacroRow("🥕 Carbs", carbsPercent, Colors.orange),
          _buildMacroRow("🍗 Protein", proteinPercent, Colors.green),
          _buildMacroRow("🥑 Fats", fatsPercent, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildMacroRow(String label, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: Colors.grey[800],
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 10),
          Text("${percent.toStringAsFixed(0)}%", style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;

  CircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint baseCircle = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final Paint progressCircle = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    canvas.drawCircle(center, radius, baseCircle);

    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, false, progressCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
