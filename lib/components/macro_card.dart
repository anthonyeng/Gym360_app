import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  final String amount;
  final String label;
  final String emoji;
  final Color color;

  const MacroCard({
    super.key,
    required this.amount,
    required this.label,
    required this.emoji,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1D), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontFamily: 'SF Pro')),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: 4,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(emoji, style: const TextStyle(fontSize: 14))
            ],
          )
        ],
      ),
    );
  }
}
