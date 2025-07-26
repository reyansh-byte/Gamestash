import 'package:flutter/material.dart';
import 'package:gamestash/login.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 150,right: 280,bottom: 100),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF2a2a2a),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.orbitron(
                      color: Color(0xFF00FF66),
                      fontSize: 36,
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
                  SizedBox(height: 22),
                  SizedBox(
                    width: 319,
                    height: 63,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Color(0xFF2a2a2a),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: 22),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Request Reset"),

                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
