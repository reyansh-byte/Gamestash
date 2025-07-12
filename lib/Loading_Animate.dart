import 'package:flutter/material.dart';
import 'dart:math';

class XboxLoadingAnimation extends StatefulWidget {
  const XboxLoadingAnimation({super.key});

  @override
  State<XboxLoadingAnimation> createState() => _XboxLoadingAnimationState();
}

class _XboxLoadingAnimationState extends State<XboxLoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 280,
              height: 120,
              child: Stack(
                children: [
                  _buildIndividualButton('assets/Y.png', 0),
                  _buildIndividualButton('assets/X.png', 1),
                  _buildIndividualButton('assets/A.png', 2),
                  _buildIndividualButton('assets/B.png', 3),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndividualButton(String imagePath, int buttonIndex) {
    // Each button gets 0.3 of the total animation time with more gaps
    double buttonDuration = 0.3;
    double startTime = buttonIndex * 0.25; // More gap between buttons
    double endTime = startTime + buttonDuration;

    double offsetY = 0;
    double scale = 1.0;
    double opacity = 0.7;

    // Only animate if we're in this button's time window
    if (_animation.value >= startTime && _animation.value <= endTime) {
      double localProgress = (_animation.value - startTime) / buttonDuration;

      // Bounce animation
      double bounceHeight = 30;
      offsetY = sin(localProgress * pi) * bounceHeight;

      // Scale animation
      scale = 1.0 + (sin(localProgress * pi) * 0.2);

      // Opacity animation
      opacity = 0.7 + (sin(localProgress * pi) * 0.3);
    }

    double baseX = buttonIndex * 60.0 + 20;
    double baseY = 50;

    return Positioned(
      left: baseX,
      top: baseY - offsetY,
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 60,
            height: 60,
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}