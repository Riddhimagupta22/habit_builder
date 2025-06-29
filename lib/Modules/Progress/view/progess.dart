import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/analytics_controller.dart';
import '../widget/chart.dart';

class Progess extends StatelessWidget {
  const Progess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _streakController = Get.find<StreakController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Progress",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w700,
            fontSize: 29,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Obx(() => HeatMap(
                  startDate: DateTime.now(),
                  endDate: DateTime.now().add(const Duration(days: 100)),
                  datasets:
                      Map<DateTime, int>.from(_streakController.streakData),
                  colorMode: ColorMode.color,
                  showText: false,
                  scrollable: true,
                  colorsets: const {
                    1: Color.fromRGBO(255, 235, 217, 1),
                    2: Color.fromRGBO(255, 217, 188, 1),
                    3: Color.fromRGBO(255, 199, 158, 1),
                    4: Color.fromRGBO(255, 174, 120, 1),
                    5: Color.fromRGBO(255, 148, 82, 1),
                    6: Color.fromRGBO(255, 122, 44, 1),
                    7: Color.fromRGBO(255, 105, 22, 1),
                    8: Color.fromRGBO(255, 92, 0, 1),
                    9: Color.fromRGBO(204, 74, 0, 1),
                    10: Color.fromRGBO(153, 55, 0, 1),
                  },
                  onClick: (date) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Date clicked: $date')),
                    );
                  },
                )),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Weekly Progress",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            final streakDates = _streakController.streakData.keys
                .map((date) => date.toIso8601String())
                .toList();

            final weeklyData =
                _streakController.getWeeklyCompletionData(streakDates);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Chart(data: weeklyData),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
