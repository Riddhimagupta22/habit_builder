import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/habit_controller.dart';
import '../../Add habit/add_habit.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final habitController = Get.put(HabitController());

  @override
  void initState() {
    super.initState();
    habitController.fetchHabit(); // ✅ fetch only once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
        centerTitle: true,
      ),
      body: Obx(() {
        print("Habit list: ${habitController.HabitList.length}");

        if (habitController.HabitList.isEmpty) {
          return Center(
            child: Text(
              "No habits added yet!",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: habitController.HabitList.length,
          itemBuilder: (context, index) {
            final habit = habitController.HabitList[index];

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(habit.name),
                subtitle: Text(habit.description),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    Text("${habit.completeddates.length} days"),
                  ],
                ),
                onLongPress: () {
                  habitController.removeHabit(habit.id);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddHabitScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
