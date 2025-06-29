import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Center(
      child: Container(
        height: 220,
        width: 320,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(47, 125, 121, 0.3),
              offset: const Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 6,
            )
          ],
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 92, 0, 1),
              Color.fromRGBO(255, 164, 80, 1),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: quote == null
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '"${quote!.q}"',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '- ${quote!.a}',
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
