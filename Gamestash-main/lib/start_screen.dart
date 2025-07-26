import 'package:flutter/material.dart';
import 'package:gamestash/login.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/comp_logo.png',
                width: 390,
                height: 80,
                fit: BoxFit.contain,
              ),
              Text(
                '"Your Gaming Journey, Organized."',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  color: Color(0xFF00FF66),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF00FF66),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      color: Color(0xFF00FF66),
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 250),
              SizedBox(
                width: 319,
                height: 63,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF00FF66),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      textStyle: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Begin Your Quest"),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

