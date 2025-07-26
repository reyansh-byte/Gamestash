import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
import 'package:gamestash/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _portalController;
  late AnimationController _controllerAnimationController;
  late AnimationController _logoController;
  late Animation<double> _controllerScale;
  late Animation<double> _controllerY;
  late Animation<double> _controllerX;
  late Animation<double> _portalScale;
  late Animation<double> _portalOpacity;
  late Animation<double> _logoReveal;

  @override
  void initState() {
    super.initState();

    _portalController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _controllerAnimationController = AnimationController(
      duration: Duration(milliseconds: 3500), // Extended for slide animation
      vsync: this,
    );

    _logoController = AnimationController(
      duration: Duration(milliseconds: 2500), // Slower for more dramatic effect
      vsync: this,
    );

    final customCurve = Cubic(1.0, 0.0, 0.0, 1.0);

    _controllerScale = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controllerAnimationController,
        curve: Interval(0.0, 0.3, curve: Curves.elasticOut),
      ),
    );

    _controllerY =
        TweenSequence<double>([
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 0.0,
              end: -200.0,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: -200.0,
              end: 0.0,
            ).chain(CurveTween(curve: Curves.bounceOut)),
            weight: 50.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controllerAnimationController,
            curve: Interval(0.0, 0.7, curve: Curves.linear),
          ),
        );

    // Slide animation that starts after the spring animation completes
    _controllerX = Tween<double>(begin: 0.0, end: -150.0).animate(
      CurvedAnimation(
        parent: _controllerAnimationController,
        curve: Interval(0.7, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // Logo reveal animation - curtain-like reveal with smooth acceleration
    _logoReveal = Tween<double>(begin: -0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOutCubic, // Smoother, more dramatic curve
      ),
    );

    // Portal animations
    _portalScale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _portalController,
        curve: Interval(0.5, 1.0, curve: customCurve),
      ),
    );

    _portalOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _portalController,
        curve: Interval(0.6, 1.0, curve: customCurve),
      ),
    );

    Future.delayed(Duration(milliseconds: 1), () {
      _portalController.forward();

      Future.delayed(Duration(milliseconds: 750), () {
        _controllerAnimationController.forward().then((_) {
          // Wait a bit after controller slide completes, then start logo reveal
          Future.delayed(Duration(milliseconds: 300), () {
            _logoController.forward().then((_) {
              _navigateToLoading();
            });
          });
        });
      });
    });
  }

  void _navigateToLoading() {
    // Add smooth page transition animation
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // Replace this with your actual next screen widget
          return StartScreen(); // Change this to your actual screen
        },
        transitionDuration: Duration(milliseconds: 800), // 800ms duration
        reverseTransitionDuration: Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Gentle curve animation (similar to Figma's "Gentle")
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic, // Gentle, smooth curve
          );

          // Smart animate effect - fade + slight scale
          return FadeTransition(
            opacity: curvedAnimation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.95,
                end: 1.0,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _portalController.dispose();
    _controllerAnimationController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  Widget _buildXboxController() {
    return Container(
      width: 85,
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Image.asset('assets/game-console.png', fit: BoxFit.contain),
    );
  }

  Widget _buildCompanyLogo() {
    // Only show logo AFTER controller has completely finished sliding left
    if (_logoController.status == AnimationStatus.dismissed) {
      return Container(); // Return empty container until logo animation starts
    }

    return Container(
      width: 280,
      height: 40,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRect(
        child: Stack(
          children: [
            // The logo image
            Image.asset(
              'assets/comp_logo.png',
              width: 280,
              height: 40,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
            // Animated curtain overlay - starts covering everything, reveals from G (left to right)
            Positioned(
              left: 280 * _logoReveal.value, // Curtain moves from left to right
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black,
                      Colors.black,
                    ],
                    stops: [0.0, 0.3, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            _portalController.reset();
            _controllerAnimationController.reset();
            _logoController.reset();
            Future.delayed(Duration(milliseconds: 1), () {
              _portalController.forward();
              Future.delayed(Duration(milliseconds: 750), () {
                _controllerAnimationController.forward().then((_) {
                  _logoController.forward();
                });
              });
            });
          },
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _portalController,
              _controllerAnimationController,
              _logoController,
            ]),
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Portal background
                  Transform.scale(
                    scale: _portalScale.value,
                    child: Opacity(
                      opacity: _portalOpacity.value,
                      child: ClipOval(
                        child: Container(
                          width: 280,
                          height: 92,
                          decoration: BoxDecoration(
                            color: Color(0xFF00FF2F),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF00FF2F).withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Controller with fly-out, spring, and slide animations
                  Transform.translate(
                    offset: Offset(_controllerX.value, _controllerY.value),
                    child: Transform.scale(
                      scale: _controllerScale.value,
                      child: _buildXboxController(),
                    ),
                  ),
                  // Company logo that appears ONLY after controller slide is complete
                  Transform.translate(
                    offset: Offset(50, 0), // Position it next to the controller
                    child: _buildCompanyLogo(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
