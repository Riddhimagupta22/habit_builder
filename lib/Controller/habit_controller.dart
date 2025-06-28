import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/Models/habit_model.dart';

class HabitController extends GetxController {
  var habitList = <HabitModel>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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
  Future<void> updateHabit(HabitModel habit) async {
    try {
      await _firestore.collection('habits').doc(habit.id).update(habit.toMap());
      fetchHabit();
    } catch (e) {
      print("Update Error: $e");
    }
  }


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

  // Remove Habit
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

  // Mark Completion Dates
  Future<void> markDateAsCompleted(String habitId, String date) async {
    try {
      await _firestore.collection('habits').doc(habitId).update({
        'completedDates': FieldValue.arrayUnion([date])
      });
      print('Date $date marked as completed for habit $habitId');
    } catch (e) {
      print('Failed to mark date as completed: $e');
    }
  }
}
