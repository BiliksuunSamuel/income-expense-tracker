import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ie_montrac/models/transaction.chart.data.dart';

import '../theme/app.colors.dart';
import '../utils/dimensions.dart';

class SpendFrequencyChart extends StatelessWidget {
  final List<TransactionChartData> chartData;
  const SpendFrequencyChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getPadding(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spend Frequency',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: Dimensions.getHeight(120),
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    spots: chartData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.amount);
                    }).toList(),
                    color: AppColors.primaryColor.withOpacity(1),
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primaryColor.withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
