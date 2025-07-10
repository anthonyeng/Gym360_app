import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        

            const Text("📏 Body Composition",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
            SizedBox(height: 10),
            const Text("🧍 Height: 178 cm", style: TextStyle(color: Colors.white, fontSize: 16)),
            const Text("⚖️ Weight: 72.5 kg", style: TextStyle(color: Colors.white, fontSize: 16)),
            const Text("📉 Body Fat %: 17.3%", style: TextStyle(color: Colors.white, fontSize: 16)),
            const Text("🔢 BMI: 22.9", style: TextStyle(color: Colors.white, fontSize: 16)),
            const Text("💪 Lean Mass: 59.9 kg", style: TextStyle(color: Colors.white, fontSize: 16)),
            const Text("⚠️ Visceral Fat Level: Normal", style: TextStyle(color: Colors.white, fontSize: 16)),

            const SizedBox(height: 30),

            const Text("📐 Body Measurements",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
            SizedBox(height: 10),
            const Text("• Chest: 98 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Waist: 82 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Hips: 95 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Neck: 37 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Left Arm: 31 cm / Right Arm: 31.5 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Left Leg: 56 cm / Right Leg: 55.5 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Calves: 37.2 cm / 38.0 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Shoulder Width: 44 cm", style: TextStyle(color: Colors.white, fontSize: 15)),
            const Text("• Torso Length: 55 cm", style: TextStyle(color: Colors.white, fontSize: 15)),

            const SizedBox(height: 30),

            const Text("🧠 AI Analysis",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
            SizedBox(height: 10),
            const Text("• 🔶 Mild forward shoulder posture", style: TextStyle(color: Colors.white70, fontSize: 15)),
            const Text("• ✅ Pelvic alignment: Balanced", style: TextStyle(color: Colors.white70, fontSize: 15)),
            const Text("• ⚠️ Left arm smaller than right by 0.5 cm", style: TextStyle(color: Colors.white70, fontSize: 15)),
            const Text("• ⚖️ Body shape: Lean Mesomorph", style: TextStyle(color: Colors.white70, fontSize: 15)),

            const SizedBox(height: 30),

            const Text("🔥 Daily Calorie Goal",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
            SizedBox(height: 6),
            const Text("2,178 kcal", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 30),

            // ✅ Recommendations
            const Text("✅ AI Recommendations",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
            SizedBox(height: 10),
            const Text("• Eat more lean protein", style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6)),
            const Text("• Add HIIT 2x/week", style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6)),
            const Text("• Focus on upper back + chest mobility", style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6)),
            const Text("• Sleep 7–8 hours", style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6)),
            const Text("• Drink 2.5L water daily", style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6)),

            const SizedBox(height: 40),

            // 📈 Placeholder
            const Text("📈 Progress Over Time (Coming Soon)",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
