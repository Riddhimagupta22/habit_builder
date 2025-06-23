import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/Controller/habit_controller.dart';

import '../../Models/habit_model.dart';

class AddHabitScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final habitController = Get.put(HabitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Habit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Habit Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final description = descriptionController.text.trim();

                if (name.isEmpty || description.isEmpty) {
                  Get.snackbar("Error", "Please fill all fields",
                      backgroundColor: Colors.red.shade100);
                  return;
                }

                final newHabit = HabitModel(
                  id: '', // Leave it empty; Firestore will assign later
                  name: name,
                  description: description,
                  completeddates: [],
                );

                await habitController.addHabit(newHabit);
                await habitController.fetchHabit(); // Force refresh
                Get.back();
              },
              child: Text('Add Habit'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
