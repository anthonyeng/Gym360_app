import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String mealName;
  final int calories;
  final int grams;
  final Map<String, double> nutritionValues;
  final List<String> identifiedIngredients;

  const ResultPage({
    super.key,
    required this.mealName,
    required this.calories,
    required this.grams,
    required this.nutritionValues,
    required this.identifiedIngredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Meal Name + Calories + Grams
            Text(
              mealName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$calories kcal   •   $grams grams',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            // Tags (mocked for now)
            Wrap(
              spacing: 8,
              children: [
                _buildTag('Rich in protein'),
                _buildTag('Rich in vitamins & minerals'),
              ],
            ),
            const SizedBox(height: 24),
            // Nutrition Values
            const Text(
              'Nutrition values',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...nutritionValues.entries.map((entry) {
              return _buildNutritionBar(entry.key, entry.value);
            }).toList(),
            const SizedBox(height: 24),
            // Ingredients Identified
            const Text(
              'Ingredients Identified',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...identifiedIngredients.map((ingredient) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '• $ingredient',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            const SizedBox(height: 32),
            // Save Meal for Today button
            ElevatedButton(
              onPressed: () {
                debugPrint('Save Meal for Today pressed');
                // TODO: connect to your backend to save the meal
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meal saved for today!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Save Meal for Today',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.green, fontSize: 14),
      ),
    );
  }

  Widget _buildNutritionBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ${value.toStringAsFixed(1)}g',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: (value / 50).clamp(0.0, 1.0), // assuming 50g max for demo
            backgroundColor: Colors.grey.shade300,
            color: Colors.green,
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
