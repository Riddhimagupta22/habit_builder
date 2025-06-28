import 'package:flutter/material.dart';

class TextCont extends StatelessWidget {
  final TextEditingController controller;
  int maxLine;
  TextCont({super.key, required this.maxLine, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(237, 237, 237, 1)),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(237, 237, 237, 1), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
    );
  }
}
