import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

BarChartGroupData makeGroupData(int x, double income, double outcome) {

  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: income,
        color: backgroundGreenColor,
        width: 15,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      BarChartRodData(
        toY: outcome,
        color: backgroundWarningColor,
        width: 15,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
    ],
  );
}

 List<BarChartGroupData> createBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: 120, color: Colors.green, width: 12),
        BarChartRodData(toY: 100, color: textWarningColor, width: 12),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 140, color: Colors.green, width: 12),
        BarChartRodData(toY: 100, color: textWarningColor, width: 12),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 120, color: Colors.green, width: 12),
        BarChartRodData(toY: 100, color: textWarningColor, width: 12),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(toY: 120, color: Colors.green, width: 12),
        BarChartRodData(toY: 100, color: textWarningColor, width: 12),
      ]),
      BarChartGroupData(x: 4, barRods: [
        BarChartRodData(toY: 120, color: Colors.green, width: 12),
        BarChartRodData(toY: 100, color: textWarningColor, width: 12),
      ]),
    ];
  }
