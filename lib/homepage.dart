import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<_NavItemData> _navItems = [
    _NavItemData('assets/home.png', 'Home'),
    _NavItemData('assets/compass.png', 'Discover'),
    _NavItemData('assets/game.png', 'Games'),
    _NavItemData('assets/profile-candidate.png', 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Stack(
        children: [
          CurvedNavigationBar(
            height: 70,
            index: _currentIndex,
            backgroundColor: Colors.black,
            color: Colors.grey[900]!,
            buttonBackgroundColor: Colors.transparent,
            items: List.generate(_navItems.length, (index) {
              final isSelected = _currentIndex == index;

              if (isSelected) {
                return Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C851),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      _navItems[index].iconPath,
                      width: 35,
                      height: 35,
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return Image.asset(
                  _navItems[index].iconPath,
                  width: 35,
                  height: 35,
                  color: Colors.white,
                );
              }
            }),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // Text labels overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              child: Row(
                children: List.generate(_navItems.length, (index) {
                  final isSelected = _currentIndex == index;
                  return Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _navItems[index].label,
                        style: GoogleFonts.orbitron(
                          color: isSelected ? Color(0xFF00C851) : Colors.white,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemData {
  final String iconPath;
  final String label;

  const _NavItemData(this.iconPath, this.label);
}