import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  String title, label;
  final VoidCallback? OnTap;
  TitleWidget({super.key, required this.title, required this.label, this.OnTap });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: OnTap,
          child: Row(
            children: [
              Text(
                label,
                style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(255, 92, 0, 1)),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color.fromRGBO(255, 92, 0, 1),
                size: 14,
              )
            ],
          ),

        ),
      ],
    );
  }
}
