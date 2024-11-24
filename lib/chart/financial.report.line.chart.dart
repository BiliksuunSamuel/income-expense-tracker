import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class FinancialReportLineChart extends StatelessWidget {
  const FinancialReportLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.getHeight(200),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(2, 3),
                FlSpot(4, 2),
                FlSpot(6, 5),
                FlSpot(8, 3),
              ],
              isCurved: true,
              color: Color(0xFF7C4DFF),
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Color(0xFF7C4DFF).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
