import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Controller/habit_controller.dart';
import '../../../Models/habit_model.dart';
import '../../Comman/Wiget/custom_datepicker.dart';
import '../../Comman/Wiget/custom_rowfield.dart';
import '../../Comman/Wiget/label_text.dart';
import '../../Comman/Wiget/text_cont.dart';

class EditHabit extends StatefulWidget {
  final HabitModel habit;

  const EditHabit({super.key, required this.habit});

  @override
  State<EditHabit> createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  final _goalController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _periodController = TextEditingController();
  final _habitTypeController = TextEditingController();
  bool _isReminderEnabled = false;

  final habitController = Get.find<HabitController>();

  @override
  void initState() {
    super.initState();
    _goalController.text = widget.habit.name;
    _descriptionController.text = widget.habit.description;
    _dateController.text = DateFormat.yMMMMd().format(widget.habit.startdate);
    _periodController.text = widget.habit.period;
    _habitTypeController.text = widget.habit.habitType;
    _isReminderEnabled = widget.habit.isReminderEnabled;
  }

  void _updateHabit() async {
    try {
      final updatedHabit = HabitModel(
        id: widget.habit.id,
        name: _goalController.text.trim(),
        description: _descriptionController.text.trim(),
        startdate: DateFormat.yMMMMd().parse(_dateController.text.trim()),
        period: _periodController.text.trim(),
        habitType: _habitTypeController.text.trim(),
        isReminderEnabled: _isReminderEnabled,
      );

      await habitController.updateHabit(updatedHabit);
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Habit updated")),
      );
    } catch (e) {
      print("Update error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update habit")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(252, 252, 255, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Edit Habit Goal",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromRGBO(47, 47, 47, 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Color.fromRGBO(225, 224, 224, 1.0),
            ),
            const SizedBox(height: 16),

            // Your Goal
            const Label("Your Goal"),
            const SizedBox(height: 10),
            TextCont(
              maxLine: 1,
              controller: _goalController,
            ),

            const SizedBox(height: 16),

            // Description
            const Label("Description"),
            const SizedBox(height: 10),
            TextCont(
              maxLine: 3,
              controller: _descriptionController,
            ),

            const SizedBox(height: 16),

            // Date
            const Label("Date"),
            const SizedBox(height: 10),
            CustomDatePicker(controller: _dateController),

            const SizedBox(height: 16),

            // Period and Habit Type
            Row(
              children: [
                Expanded(
                    child: CustomField(
                  label: "Period",
                  hintText: "1 Month (30 Days)",
                  controller: _periodController,
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: CustomField(
                  label: "Habit Type",
                  hintText: "Everyday",
                  controller: _habitTypeController,
                )),
              ],
            ),

            const SizedBox(height: 16),

            // Reminder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable Reminder Notification",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(47, 47, 47, 1),
                  ),
                ),
                Switch(
                  value: _isReminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isReminderEnabled = value;
                    });
                  },
                  activeColor: const Color.fromRGBO(67, 136, 131, 1),
                ),
              ],
            ),
            const SizedBox(height: 45),
            GestureDetector(
              onTap: _updateHabit,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 92, 0, 1),
                      Color.fromRGBO(255, 164, 80, 1),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Update Habit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
