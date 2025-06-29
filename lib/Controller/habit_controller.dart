import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/Models/habit_model.dart';

import 'analytics_controller.dart';

class HabitController extends GetxController {
  var habitList = <HabitModel>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _streakController = Get.find<StreakController>();

  //Add Habit
  Future<void> addHabit(HabitModel habit) async {
    final currentuser = _auth.currentUser;

    if (currentuser == null) {
      print("Cannot add Habit: No user is logged in");
      return;
    }

    final data = habit.toMap();
    data['userId'] = currentuser.uid;

    print("Final habit data being sent to Firestore: $data");

    try {
      final docRef = await _firestore.collection('habits').add(data);
      print("Habit added with ID: ${docRef.id}");
      fetchHabit();
    } catch (e) {
      print('Firestore write failed: $e');
    }
  }

  //Update Habit
  Future<void> editHabit(HabitModel habit) async {
    try {
      await _firestore.collection('habits').doc(habit.id).update(habit.toMap());
      fetchHabit();
    } catch (e) {
      print("Update Error: $e");
    }
  }

  //Fetch Habits
  void fetchHabit() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      print("Cannot fetch Habits: No user is logged in");
      return;
    }

    try {
      _firestore
          .collection('habits')
          .where('userId', isEqualTo: currentUser.uid)
          .snapshots()
          .listen((snapshot) {
        print("Fetched ${snapshot.docs.length} habits");
        habitList.value = snapshot.docs.map((doc) {
          return HabitModel.fromMap(doc.id, doc.data());
        }).toList();
      });
    } catch (e) {
      print('Failed to fetch Habits: $e');
    }
  }

  //Remove Habit
  Future<void> removeHabit(String habitId) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      print("Cannot remove Habit: No user is logged in");
      return;
    }

    try {
      await _firestore.collection('habits').doc(habitId).delete();
      print('Habit deleted successfully');
    } catch (e) {
      print('Failed to delete Habit: $e');
    }
  }

  //Toggle Completion 
  void toggleHabitCompletion(String habitId, bool isCompleted) async {
    final index = habitList.indexWhere((habit) => habit.id == habitId);
    if (index != -1) {

      habitList[index].isCompleted = isCompleted;
      habitList.refresh();

     
      try {
        await _firestore.collection('habits').doc(habitId).update({
          'isCompleted': isCompleted,
        });
        print('Habit completion updated in Firestore');
      } catch (e) {
        print('Failed to update isCompleted in Firestore: $e');
      }


      DateTime today = DateTime.now();
      _streakController.toggleStreakForDate(today, isCompleted: isCompleted);
    }
  }
}
