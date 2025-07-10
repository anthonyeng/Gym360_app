import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const Gym360App());
}

class Gym360App extends StatelessWidget {
  const Gym360App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym 360',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
