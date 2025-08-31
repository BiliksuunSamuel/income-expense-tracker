import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/utilities.dart';

import '../utils/dimensions.dart';

class DateTimeSeparator extends StatelessWidget {
  final DateTime datetime;
  const DateTimeSeparator({super.key, required this.datetime});

  @override
  Widget build(BuildContext context) {
    var day = convertToNth(datetime.day);
    var month = convertMonth(datetime.month);
    var value = datetime.isToday() ? "Today" : "$day $month ${datetime.year}";
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.getPadding(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(flex: 2, child: Divider()),
          Expanded(
            flex: 4,
            child: Container(
              clipBehavior:
                  Clip.antiAlias, // optional, helps prevent paint spill
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.getPadding(4),
                horizontal: Dimensions.getPadding(8),
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.getBorderRadius(20)),
                color: Colors.grey.withValues(alpha: 0.15),
              ),
              child: Center(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: AppFontSize.fontSizeSmall(
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.getFontSize(12),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: Divider()),
        ],
      ),
    );
  }
}
