import 'package:flutter/material.dart';

class WaterCard extends StatelessWidget {
  final int currentOz;
  final int goalOz;
  final VoidCallback onAddWater;

  const WaterCard({
    super.key,
    required this.currentOz,
    required this.goalOz,
    required this.onAddWater,
  });

  @override
  Widget build(BuildContext context) {
    final int safeCurrentOz = currentOz < 0 ? 0 : currentOz;
    final double progress = (safeCurrentOz / goalOz).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("💧", style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Text(
                "$safeCurrentOz / $goalOz oz",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro',
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                onPressed: onAddWater,
                child: const Text("+8 oz", style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
