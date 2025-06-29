import 'package:get_storage/get_storage.dart';

class HabitStorage {
  final box = GetStorage();

  void saveHabitofDay(String title, String id) {
    box.write('habitTitle', title);
    box.write('habitId', id);
    box.write('lastUpdated', DateTime.now());}

    String? getHabitTitle() => box.read('habitTitle');
    DateTime? getLastUpdated() {
      return box.read('lastUpdated') != null
          ? DateTime.tryParse(box.read('lastUpdated'))
          : null;
    }

}
