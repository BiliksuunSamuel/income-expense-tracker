import 'package:flutter/material.dart';
import 'package:ie_montrac/screens/home/expense.tracker.screen.dart';
import 'package:ie_montrac/views/app.view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppView(
      body: ExpenseTrackerScreen(),
    );
  }
}
