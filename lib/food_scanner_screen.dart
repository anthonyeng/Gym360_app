import 'package:flutter/material.dart';
import 'components/calorie_chart.dart';
import 'components/suggested_meal_card.dart';
import 'meal_scan_screen.dart'; // Make sure this exists

class FoodScannerScreen extends StatelessWidget {
  const FoodScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: const [
                  CalorieChart(
                    totalCalories: 568.1,
                    goalCalories: 1200,
                    carbsPercent: 50,
                    proteinPercent: 40,
                    fatsPercent: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '🍽 Suggested Meals',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'View all',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  SuggestedMealCard(
                    title: "Green Vegetables",
                    subtitle: "Balance",
                    quantity: "100 grams",
                    imageUrl:
                        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
                    carbs: 4.8,
                    protein: 4.4,
                    fats: 0.4,
                  ),
                  SuggestedMealCard(
                    title: "Grilled Chicken",
                    subtitle: "High Protein",
                    quantity: "150 grams",
                    imageUrl:
                        "https://images.unsplash.com/photo-1600891964599-f61ba0e24092",
                    carbs: 0,
                    protein: 30,
                    fats: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MealScanScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan Meal"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
