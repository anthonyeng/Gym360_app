import 'package:flutter/material.dart';

class SuggestedMealCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String quantity;
  final String imageUrl;
  final double carbs;
  final double protein;
  final double fats;

  const SuggestedMealCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.quantity,
    required this.imageUrl,
    required this.carbs,
    required this.protein,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "$subtitle • $quantity",
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: [
                    _buildMacro("🥕", carbs, Colors.orange),
                    _buildMacro("🍗", protein, Colors.green),
                    _buildMacro("🥑", fats, Colors.purple),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMacro(String emoji, double value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(
          "${value.toStringAsFixed(1)}g",
          style: TextStyle(
              color: color, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
