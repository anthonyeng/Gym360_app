import 'package:flutter/material.dart';

class CalorieSummary extends StatelessWidget {
  const CalorieSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xFF1A1A1D), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("2,178", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'SF Pro')),
              SizedBox(height: 4),
              Text("Calories left", style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'SF Pro'))
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.8,
                  strokeWidth: 6,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
              ),
              Text("🔥", style: TextStyle(fontSize: 20))
            ],
          )
        ],
      ),
    );
  }
}
