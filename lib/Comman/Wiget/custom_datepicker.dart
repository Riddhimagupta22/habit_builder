import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;

  const CustomDatePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          FocusScope.of(context).unfocus();
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1999),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          }
        },
        decoration: InputDecoration(
          hintText: "Select start date",
          hintStyle: GoogleFonts.nunito(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(47, 47, 47, 1),
          ),
          suffixIcon: const Icon(Icons.calendar_today,
              color: Color.fromRGBO(136, 136, 136, 1)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(237, 237, 237, 1)),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(237, 237, 237, 1)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
