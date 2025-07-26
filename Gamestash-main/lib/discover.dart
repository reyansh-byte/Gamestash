import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Discover Page',
        style: GoogleFonts.orbitron(color: Colors.white, fontSize: 24),
      ),
    );
  }
}