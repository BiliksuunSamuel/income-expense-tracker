import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/screens/home/budget.screen.dart';
import 'package:ie_montrac/screens/home/expense.tracker.screen.dart';
import 'package:ie_montrac/screens/home/profile/profile.screen.dart';
import 'package:ie_montrac/screens/home/transactions.screen.dart';

import '../../views/bottom.appbar.view.dart';
import '../../views/floating.action.menu.view.dart';
import 'add.expense.screen.dart';
import 'add.income.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String selectedTimePeriod = 'Today';
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  late AnimationController _animationController;
  //
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }
  //

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  final List<Widget> _screens = [
    const ExpenseTrackerScreen(),
    const TransactionsScreen(),
    const BudgetScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex],
          FloatingActionMenuView(
            isVisible: _isMenuOpen,
            handleExpensePressed: () {
              Get.to(() => const AddExpenseScreen());
              _toggleMenu();
            },
            handleIncomePressed: () {
              Get.to(() => const AddIncomeScreen());
              _toggleMenu();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_main',
        onPressed: _toggleMenu,
        backgroundColor: Colors.deepPurple,
        shape: const CircleBorder(),
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: Colors.white,
          progress: _animationController,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppbarView(
        selectedIndex: _selectedIndex,
        handleIndex: (int index) {
          _onTabTapped(index);
        },
      ),
    );
  }
}
