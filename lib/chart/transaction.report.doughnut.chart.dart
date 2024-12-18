import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

import '../models/chart.segment.dart';

class TransactionReportDoughnutChart extends StatelessWidget {
  final double totalAmount;
  final List<ChartSegment> segments;
  final String currency;

  const TransactionReportDoughnutChart(
      {Key? key,
      required this.totalAmount,
      required this.segments,
      required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: Dimensions.getWidth(300),
          width: Dimensions.getWidth(300),
          child: PieChart(
            PieChartData(
              sections: segments.map((segment) {
                return PieChartSectionData(
                  color: segment.color,
                  value: segment.value,
                  title: '',
                  radius: Dimensions.getWidth(25),
                  showTitle: false,
                );
              }).toList(),
              sectionsSpace: 0,
              centerSpaceRadius: Dimensions.getBorderRadius(120),
              startDegreeOffset: -90,
            ),
          ),
        ),
        Text(
          '$currency ${totalAmount.toStringAsFixed(2)}',
          style: AppFontSize.fontSizeTitle(
            fontSize: Dimensions.getFontSize(22),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
