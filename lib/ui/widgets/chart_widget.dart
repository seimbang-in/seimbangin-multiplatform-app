import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seimbangin_app/models/donut_chart_model.dart';
import 'package:seimbangin_app/services/chart_service.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class AnalyticsBarChart extends StatelessWidget {
  const AnalyticsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 2,
                dashArray: [10, 10],
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Jan');
                    case 1:
                      return Text('Feb');
                    case 2:
                      return Text('Mar');
                    case 3:
                      return Text('Apr');
                    case 4:
                      return Text('May');
                    default:
                      return Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      '${value.toInt()}',
                      textAlign: TextAlign.right,
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: createBarGroups(),
        ),
      ),
    );
  }
}

class AnalyticsDonutChart extends StatefulWidget {
  final List<ChartSection> sections;
  const AnalyticsDonutChart({super.key, required this.sections});

  @override
  State<AnalyticsDonutChart> createState() => _AnalyticsDonutChartState();
}

class _AnalyticsDonutChartState extends State<AnalyticsDonutChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final chartSize = constraints.maxWidth * 0.8; // 80% dari parent width

        return Center(
          child: SizedBox(
            width: chartSize,
            height: chartSize,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      touchedIndex =
                          response?.touchedSection?.touchedSectionIndex ?? -1;
                    });
                  },
                ),
                sectionsSpace: 0,
                centerSpaceRadius: chartSize * 0.2, // auto size tengah
                sections: _buildSections(chartSize),
              ),
            ),
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _buildSections(double chartSize) {
    return List.generate(widget.sections.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? chartSize * 0.05 : chartSize * 0.03;
      final radius = isTouched ? chartSize * 0.35 : chartSize * 0.3;

      return PieChartSectionData(
        color: widget.sections[i].color,
        value: widget.sections[i].value,
        radius: radius,
        title:
            "${widget.sections[i].title} ${widget.sections[i].value.toStringAsFixed(0)}%",
        showTitle: true,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }
}
