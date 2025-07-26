import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Games Page',
        style: GoogleFonts.orbitron(color: Colors.white, fontSize: 24),
      ),
    );
  }
}