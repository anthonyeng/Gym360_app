import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final int newsIndex;
  final List<Map<String, String>> gymNews;
  final int daysUntilNextScan;

  const NewsCard({
    super.key,
    required this.newsIndex,
    required this.gymNews,
    required this.daysUntilNextScan,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: Container(
        key: ValueKey<int>(newsIndex),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1D),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gymNews[newsIndex]['title'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              gymNews[newsIndex]['content'] ?? '',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              gymNews[newsIndex]['time'] ?? '',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "🧠 Next AI Scan In:",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontFamily: 'SF Pro',
                  ),
                ),
                Text(
                  "${daysUntilNextScan} ${daysUntilNextScan == 1 ? 'day' : 'days'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
