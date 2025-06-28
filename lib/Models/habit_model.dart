import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String id, name, description, period, habitType;
  DateTime startdate;
  bool isReminderEnabled;

  HabitModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startdate,
    required this.period,
    required this.habitType,
    required this.isReminderEnabled,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'startdate': Timestamp.fromDate(startdate),
    'period': period,
    'habitType': habitType,
    'isReminderEnabled': isReminderEnabled,
  };

  factory HabitModel.fromMap(String id, Map<String, dynamic> map) {
    return HabitModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      startdate: (map['startdate'] as Timestamp).toDate(),

      period: map['period'] ?? '',
      habitType: map['habitType'] ?? '',
      isReminderEnabled: map['isReminderEnabled'] ?? false,
    );
  }
}
