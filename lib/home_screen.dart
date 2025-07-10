import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'components/profile_header.dart';
import 'components/date_selector.dart';
import 'components/calorie_summary.dart';
import 'components/macro_card.dart';
import 'components/news_card.dart';
import 'components/water_card.dart';
import 'ResultPage.dart';
import 'food_scanner_screen.dart';


class HomeScreen extends StatefulWidget {
  final String username;
  final String profileImage;
  final String bodyWeight;
  final String fatPercentage;
  final String calories;

  const HomeScreen({
    super.key,
    required this.username,
    required this.profileImage,
    required this.bodyWeight,
    required this.fatPercentage,
    required this.calories,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  DateTime lastScanDate = DateTime.now().subtract(const Duration(days: 5));
  final int scanIntervalDays = 7;
  int newsIndex = 0;
  late Timer _newsTimer;

  int currentWaterOz = 0;
  final int waterGoalOz = 83;

  void addWater() {
    setState(() {
      currentWaterOz += 8;
      if (currentWaterOz > waterGoalOz) {
        currentWaterOz = waterGoalOz;
      }
    });
  }

  final List<Map<String, String>> gymNews = [
    {
      'title': "📢 Today’s Gym News",
      'content': "The gym will close early at 8 PM today due to maintenance. Don’t forget to retake your 360° scan if it’s been more than 7 days!",
      'time': "2 hours ago"
    },
    {
      'title': "🗓️ Weekly Health Tip",
      'content': "Add 30 minutes of stretching to your morning routine to improve flexibility and prevent injuries.",
      'time': "10 seconds ago"
    },
    {
      'title': "🔥 Motivation Monday",
      'content': "Small progress is still progress. Stay consistent and trust the process!",
      'time': "1 day ago"
    },
    {
      'title': "🏋️‍♂️ Strength Tip",
      'content': "Focus on form before increasing weight to avoid injury and maximize gains.",
      'time': "3 days ago"
    },
    {
      'title': "🥦 Nutrition Reminder",
      'content': "Don’t skip meals. Fuel your workouts with proper carbs and proteins.",
      'time': "5 days ago"
    },
    {
      'title': "📅 Event Update",
      'content': "This Saturday at 10AM: Free HIIT group session with Coach Lara! Book your spot now.",
      'time': "3 days ago"
    },
    {
      'title': "💧 Hydration Check",
      'content': "Aim for at least 2.5 liters of water daily to keep your metabolism optimal.",
      'time': "Today"
    },
    {
      'title': "⚠️ System Notice",
      'content': "App performance updates are underway. Some features may be temporarily slower.",
      'time': "4 hours ago"
    },
    {
      'title': "🛠️ Admin Announcement",
      'content': "[To be updated by admin later...]",
      'time': "Just now"
    },
  ];

 static const List<BottomNavigationBarItem> _navItems = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
];


  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  int get daysUntilNextScan {
    final nextScanDate = lastScanDate.add(Duration(days: scanIntervalDays));
    return nextScanDate.difference(DateTime.now()).inDays;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _newsTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
        if (mounted) {
          setState(() {
            newsIndex = (newsIndex + 1) % gymNews.length;
          });
        }
      });
    });
  } 
  @override
  void dispose() {
    _newsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final List<Widget> _tabContents = [
  _buildTabContent(_buildHomeTab()),
  _buildTabContent(Center(child: Text('Workout', style: TextStyle(color: Colors.white)))),
  _buildTabContent(const FoodScannerScreen()), 
  _buildTabContent(ResultPage()),
];


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(
              username: widget.username,
              profileImage: widget.profileImage,
            ),
            Expanded(child: _tabContents[_selectedIndex]),
          ],
        ),
      ),
     bottomNavigationBar: Theme(
  data: Theme.of(context).copyWith(
    splashColor: Colors.transparent,        
    highlightColor: Colors.transparent,     
  ),
  child: Container(
    color: Colors.black,
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,      
      unselectedItemColor: Colors.white,   
      onTap: _onItemTapped,
      items: _navItems,
    ),
  ),
),

    );
  }

  Widget _buildTabContent(Widget child) {
    return child;
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DateSelector(
            selectedDate: _selectedDate,
            onDateSelected: (date) => setState(() => _selectedDate = date),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const CalorieSummary(),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(child: MacroCard(amount: "142g", label: "Proteins left", emoji: "🍗", color: Colors.redAccent)),
                    SizedBox(width: 12),
                    Expanded(child: MacroCard(amount: "190g", label: "Carbs left", emoji: "🌽", color: Colors.amber)),
                    SizedBox(width: 12),
                    Expanded(child: MacroCard(amount: "40g", label: "Fats left", emoji: "🥑", color: Colors.greenAccent)),
                  ],
                ),
                const SizedBox(height: 20),
                NewsCard(
                  newsIndex: newsIndex,
                  gymNews: gymNews,
                  daysUntilNextScan: daysUntilNextScan,
                ),
                const SizedBox(height: 20),
                WaterCard(
                  currentOz: currentWaterOz,
                  goalOz: waterGoalOz,
                  onAddWater: addWater,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
