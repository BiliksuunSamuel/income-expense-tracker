import 'package:flutter/material.dart';

class ChartSegment {
  final double value;
  final Color color;

  ChartSegment({
    required this.value,
    required this.color,
  });


  static List<ChartSegment> getChartSegment(){
    return [
      ChartSegment(
        value: 60,
        color: const Color(0xFFFFB74D), // Orange segment
      ),
      ChartSegment(
        value: 30,
        color: const Color(0xFF7C4DFF), // Purple segment
      ),
      ChartSegment(
        value: 10,
        color: const Color(0xFFFF5252), // Red segment
      ),
    ];
  }
}
