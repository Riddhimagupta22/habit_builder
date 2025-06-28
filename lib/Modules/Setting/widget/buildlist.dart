import 'package:flutter/material.dart';

class Buildlist extends StatelessWidget {
   Buildlist({super.key,required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Color.fromRGBO(251, 251, 251, 1),

        ),
        child: ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          onTap: () {
            // Add navigation or action
          },
        ),
      );
    }
  }

