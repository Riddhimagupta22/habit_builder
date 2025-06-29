import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/buildlist.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        title: Text(
          "Setting",
          style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 29),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(200, 200, 200, 0.15),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Setting
                  Buildlist(
                    title: "Account",
                  ),
                  Buildlist(title: "Term and Condition"),
                  Buildlist(title: "Policy"),
                  Buildlist(title: "About App"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
