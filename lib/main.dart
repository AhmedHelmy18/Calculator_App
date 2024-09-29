import 'package:calculate_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculateApp());
}

class CalculateApp extends StatelessWidget {
  const CalculateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
