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
      margin: EdgeInsets.symmetric(vertical: Dimensions.getPadding(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(flex: 2, child: Divider()),
          Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.getPadding(8),
                    horizontal: Dimensions.getPadding(15)),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(20)),
                  color: Colors.grey.withOpacity(0.15),
                ),
                child: Center(
                  child: Text(
                    value,
                    style: AppFontSize.fontSizeSmall(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.getFontSize(12)),
                  ),
                ),
              )),
          const Expanded(flex: 2, child: Divider())
        ],
      ),
    );
  }
}
