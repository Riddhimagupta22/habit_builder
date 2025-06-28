import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/Modules/Dashboard/widget/user_widget.dart';
import 'package:intl/intl.dart';
import 'package:habit_tracker/Controller/habit_controller.dart';
import '../../Add habit/add_habit.dart';
import '../../Edit habit/Edit Habit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final habitController = Get.find<HabitController>();

  @override
  void initState() {
    super.initState();
    habitController.fetchHabit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(95, 227, 148, 1),
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const AddHabit(),
          );
          habitController.fetchHabit();
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date display
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20),
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Greeting
            UserWidget(),

            const SizedBox(height: 20),

            // Section title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today\'s habits',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, fontSize: 21)),
                  Text('See all',
                      style: GoogleFonts.nunito(
                          color: Color.fromRGBO(255, 92, 0, 1))),
                ],
              ),
            ),

            const SizedBox(height: 10),
            // list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                final habits = habitController.habitList;

                if (habits.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 310),
                    child: Text(
                      "No habits for today.",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habit = habits[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(habit.name),
                        subtitle: Text(habit.description),
                        // edit or delete
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) => EditHabit(habit: habit),
                              );
                            } else if (value == 'delete') {
                              habitController.removeHabit(habit.id);
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                                value: 'edit', child: Text('Edit')),
                            const PopupMenuItem(
                                value: 'delete', child: Text('Delete')),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
