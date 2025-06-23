import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/Models/habit_model.dart';

class HabitController extends GetxController {
  var HabitList = <HabitModel>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future addHabit(HabitModel habit) async {
    final currentuser = _auth.currentUser;

    if (currentuser == null) {
      print("Cannot add Habit: No user is logged in");
      return null;
    }
    final data = habit.toMap();
    data['userId'] = currentuser.uid;
    try {
      await _firestore.collection('habits').add(data);
      print('Habits added Successfully');
      fetchHabit();
    } catch (e) {
      print('Failed to add Habit: $e');
    }
  }

  Future<void> fetchHabit() async {
    final currentuser = _auth.currentUser;
    if (currentuser == null) {
      print("Cannot fetch Habit: No user is logged in");
      return null;
    }

    {
      try {
        await _firestore
            .collection('habits')
            .where(currentuser.uid)
            .snapshots()
            .listen((snapshot) {
          print("Fetched ${snapshot.docs.length} habits");
          HabitList.value = snapshot.docs.map((doc) {
            return HabitModel.fromMap(doc.id, doc.data());
          }).toList();
        });
      } catch (e) {
        print('Failed to fetch Habit: $e');
      }
    }
  }

  void removeHabit(String habitId) async {
    final currentuser = _auth.currentUser;

    if (currentuser == null) {
      print("Cannot add Habit: No user is logged in");
      return null;
    }
    try {
      await _firestore.collection('habits').doc(habitId).delete();
    } catch (e) {
      print('Failed to delete Habit: $e');
    }
  }

  Future<void> markedDates(String habitId, String date) async {
    try {
      await _firestore.collection('habits').doc(habitId).update({
        'completedDates': FieldValue.arrayUnion([date])
      });
      print('Date $date marked as completed for habit $habitId');
    } catch (e) {
      print('Failed to mark habit as completed: $e');
    }
  }
}
