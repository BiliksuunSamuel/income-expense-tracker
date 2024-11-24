import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ExpenseTrackerHelper {
  static Widget buildMenuItem(
      IconData icon, Color color, String tooltip, Function() toggleMenu) {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        toggleMenu();
      },
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
      tooltip: tooltip,
      heroTag: "fab_$tooltip",
    );
  }

  static Widget buildNavItem(int index, String iconPath, String label,
      int selectedIndex, Color iconColor,
      {Function()? onPressed}) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgIcon(
            path: iconPath,
            color:
                selectedIndex == index ? AppColors.primaryColor : Colors.grey,
            width: Dimensions.getWidth(18),
            height: Dimensions.getWidth(18),
          ),
          Text(
            label,
            style: AppFontSize.fontSizeSmall(
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static Widget buildTimeButton(String text, String selectedTimePeriod,
      {Function()? onPress}) {
    bool isSelected = text == selectedTimePeriod;
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onPress,
        splashColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          height: 40,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildTransactionItem(
      {required String icon,
      required Color color,
      required String title,
      required String subtitle,
      required String amount,
      required String time,
      Color? iconColor,
      Function()? onPress}) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgIcon(
              path: icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontSize.fontSizeMedium(
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.getFontSize(16),
                  ),
                ),
                Text(
                  subtitle,
                  style: AppFontSize.fontSizeMedium(
                    color: Colors.grey[600],
                    fontSize: Dimensions.getFontSize(14),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: AppFontSize.fontSizeMedium(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.getFontSize(16),
                  color: AppColors.redColor,
                ),
              ),
              Text(
                time,
                style: AppFontSize.fontSizeMedium(
                  color: Colors.grey[600],
                  fontSize: Dimensions.getFontSize(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
