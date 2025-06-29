import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StreakController extends GetxController {
  final RxMap<DateTime, int> streakData = <DateTime, int>{}.obs;

  void toggleStreakForDate(DateTime date, {bool isCompleted = true}) {
    final normalized = _normalizeDate(date);

    if (isCompleted) {
      streakData[normalized] = (streakData[normalized] ?? 0) + 1;
    } else {
      if (streakData.containsKey(normalized)) {
        final updated = (streakData[normalized]! - 1).clamp(0, 10);
        if (updated == 0) {
          streakData.remove(normalized);
        } else {
          streakData[normalized] = updated;
        }
      }
    }
  }

  void resetStreak(DateTime date) {
    final normalized = _normalizeDate(date);
    streakData.remove(normalized);
  }

  void setStreakValue(DateTime date, int value) {
    final normalized = _normalizeDate(date);

    if (value <= 0) {
      streakData.remove(normalized);
    } else {
      streakData[normalized] = value.clamp(1, 10);
    }
  }

  Map<String, int> getWeeklyCompletionData(List<String> completionDates) {
    final now = DateTime.now();
    final last7Days =
        List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));

    final Map<String, int> weeklyData = {
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };

    for (final dateStr in completionDates) {
      final parsedDate = DateTime.tryParse(dateStr);
      if (parsedDate == null) continue;

      for (final day in last7Days) {
        if (_isSameDate(parsedDate, day)) {
          final weekday = DateFormat('E').format(day);
          weeklyData[weekday] = (weeklyData[weekday] ?? 0) + 1;
        }
      }
    }

    return weeklyData;
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
