import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.colors.dart';

import '../helper/expense.tracker.dart';

class BottomAppbarView extends StatelessWidget {
  final int selectedIndex;
  const BottomAppbarView({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      notchMargin: 8.0,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ExpenseTrackerHelper.buildNavItem(0, "assets/images/home.svg",
                'Home', selectedIndex, AppColors.primaryColor),
            ExpenseTrackerHelper.buildNavItem(
                1,
                "assets/images/transaction.svg",
                'Transaction',
                selectedIndex,
                Colors.grey),
            const SizedBox(width: 40), // Space for FAB
            ExpenseTrackerHelper.buildNavItem(3, "assets/images/piechart.svg",
                'Budget', selectedIndex, Colors.grey),
            ExpenseTrackerHelper.buildNavItem(4, "assets/images/user.svg",
                'Profile', selectedIndex, Colors.grey),
          ],
        ),
      ),
    );
  }
}
