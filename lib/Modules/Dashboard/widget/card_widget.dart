import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/Services/getstorag_service.dart';
import '../../../Models/quote_model.dart';
import '../../../Services/quote_service.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  QuoteModel? quote;

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    final fetchedQuote = await QuoteService.fetchQuote();
    setState(() {
      quote = fetchedQuote;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = HabitStorage().getHabitTitle() ?? "No Habit Selected";

    return Center(
      child: Container(
        height: 260,
        width: 340,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF5E00),
              Color(0xFFFFB267),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white30, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 25, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              'Habit of the Day',
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: const Color(0xFFFFFFFFED),
              ),
            ),
            const SizedBox(height: 20),
            quote == null
                ? const CircularProgressIndicator(color: Colors.white)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '"${quote!.q}"',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '- ${quote!.a}',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
