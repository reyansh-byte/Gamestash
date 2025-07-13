import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: Colors.grey[900]!,
        buttonBackgroundColor: Colors.green,
        height: 70,
        index: _currentIndex,
        items: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/home.png',
                width: 24,
                height: 24,
                color: _currentIndex == 0 ? Colors.black : Colors.white,
              ),
              SizedBox(height: 4),
              Text(
                'Home',
                style: TextStyle(
                  color: _currentIndex == 0 ? Colors.black : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/compass.png',
                width: 24,
                height: 24,
                color: _currentIndex == 1 ? Colors.black : Colors.white,
              ),
              SizedBox(height: 4),
              Text(
                'Discover',
                style: TextStyle(
                  color: _currentIndex == 1 ? Colors.black : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/game.png',
                width: 24,
                height: 24,
                color: _currentIndex == 2 ? Colors.black : Colors.white,
              ),
              SizedBox(height: 4),
              Text(
                'Games',
                style: TextStyle(
                  color: _currentIndex == 2 ? Colors.black : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/profile_candidate.png',
                width: 24,
                height: 24,
                color: _currentIndex == 3 ? Colors.black : Colors.white,
              ),
              SizedBox(height: 4),
              Text(
                'Profile',
                style: TextStyle(
                  color: _currentIndex == 3 ? Colors.black : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          print('Tapped index: $index');
        },
      ),
    );
  }
}
