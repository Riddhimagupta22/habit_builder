import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class Chart extends StatelessWidget {
  final Map<String, int> data;

  const Chart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  if (value >= 0 && value < dayLabels.length) {
                    return Text(
                      dayLabels[value.toInt()],
                      style: GoogleFonts.nunito(fontSize: 12),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 32,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) => Text(
                  value.toInt().toString(),
                  style: GoogleFonts.nunito(fontSize: 10),
                ),
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: List.generate(7, (index) {
            final label = dayLabels[index];
            final count = data[label] ?? 0;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: count.toDouble(),
                  color: count == 0
                      ? const Color.fromRGBO(255, 217, 188, 1)
                      : const Color.fromRGBO(255, 148, 82, 1),
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
