import 'package:flutter/material.dart';

import '../helper/expense.tracker.dart';

class BottomAppbarView extends StatelessWidget {
  final int selectedIndex;
  Function(int index)? handleIndex;
  BottomAppbarView({super.key, required this.selectedIndex, this.handleIndex});

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
            ExpenseTrackerHelper.buildNavItem(
                0, "assets/images/home.svg", 'Home', selectedIndex, Colors.grey,
                onPressed: () {
              if (handleIndex != null) {
                handleIndex!(0);
              }
            }),
            ExpenseTrackerHelper.buildNavItem(
                1,
                "assets/images/transaction.svg",
                'Transaction',
                selectedIndex,
                Colors.grey, onPressed: () {
              if (handleIndex != null) {
                handleIndex!(1);
              }
            }),
            const SizedBox(width: 40), // Space for FAB
            ExpenseTrackerHelper.buildNavItem(2, "assets/images/piechart.svg",
                'Budget', selectedIndex, Colors.grey, onPressed: () {
              if (handleIndex != null) {
                handleIndex!(2);
              }
            }),
            ExpenseTrackerHelper.buildNavItem(3, "assets/images/user.svg",
                'Profile', selectedIndex, Colors.grey, onPressed: () {
              if (handleIndex != null) {
                handleIndex!(3);
              }
            }),
          ],
        ),
      ),
    );
  }
}
