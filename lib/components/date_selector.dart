import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        itemBuilder: (context, index) {
          final today = DateTime.now();
          final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
          final date = startOfWeek.add(Duration(days: index));
          final isSelected = selectedDate.day == date.day && selectedDate.month == date.month && selectedDate.year == date.year;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 48,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: isSelected ? Colors.orange : Colors.transparent, shape: BoxShape.circle),
                    child: Text(date.day.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'SF Pro')),
                  ),
                  const SizedBox(height: 4),
                  Text(DateFormat('E').format(date)[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'SF Pro')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
