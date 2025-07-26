import 'package:flutter/material.dart';
import 'package:gamestash/forget_password.dart';
import 'package:gamestash/homepage.dart';
import 'package:gamestash/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _showErrorDialog('Invalid Email Format', 'Please enter a valid email address.');
      } else if (e.code == 'user-not-found') {
        _showErrorDialog('User Not Found', 'No account exists with this email. Please sign up.');
      } else if (e.code == 'wrong-password') {
        _showErrorDialog('Incorrect Password', 'The password you entered is incorrect.');
      } else if (e.code == 'user-disabled') {
        _showErrorDialog('Account Disabled', 'This account has been disabled. Contact support.');
      } else if (e.code == 'too-many-requests') {
        _showErrorDialog('Too Many Attempts', 'Too many login attempts. Please try again later.');
      } else if (e.code == 'operation-not-allowed') {
        _showErrorDialog('Login Not Allowed', 'Email/password login is not enabled for this app.');
      } else {
        _showErrorDialog('Login Error', e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      _showErrorDialog('Unexpected Error', 'Something went wrong. Please try again.');
    }
  }
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title,
          style: GoogleFonts.orbitron(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.orbitron(
                color: const Color(0xFF00FF66),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Log In',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  color: const Color(0xFF00FF66),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                      color: Color(0xFF00FF66),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                    const Shadow(
                      color: Color(0xFF00FF66),
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: 319,
                height: 63,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color(0xFF2a2a2a),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(999),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: 319,
                height: 63,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color(0xFF2a2a2a),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(999),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 151,
                    height: 63,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF66),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        textStyle: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _login,
                      child: const Text("Log in"),
                    ),
                  ),
                  const SizedBox(width: 13),
                  SizedBox(
                    width: 151,
                    height: 63,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF66),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        textStyle: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: 319,
                height: 63,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    textStyle: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgetPassword()),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
