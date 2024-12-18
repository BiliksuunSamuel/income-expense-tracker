import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ie_montrac/models/income.expense.report.dart';
import 'package:ie_montrac/theme/app.colors.dart';

import '../utils/dimensions.dart';

class FinancialReportLineChart extends StatelessWidget {
  final List<IncomeExpenseReport> data;
  const FinancialReportLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.getHeight(150),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .map((e) => FlSpot(data.indexOf(e).toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: AppColors.primaryColor,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
