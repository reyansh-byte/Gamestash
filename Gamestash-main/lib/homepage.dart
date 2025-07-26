import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return _buildTestPage();
      default:
        return _buildTestPage();
    }
  }

  Future<void> _sendHelloToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('test').add({
        'message': 'Hello Firestore!',
        'timestamp': FieldValue.serverTimestamp(),
      });

      _showDialog('Success', 'Message saved to Firestore.', Colors.greenAccent);
    } catch (e) {
      _showDialog('Error', 'Failed to save message: $e', Colors.redAccent);
    }
  }

  Widget _buildTestPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Firestore Test',
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C851),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _sendHelloToFirestore,
                child: Text(
                  'Send Hello to Firestore',
                  style: GoogleFonts.orbitron(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(title, style: GoogleFonts.orbitron(color: color)),
        content: Text(message, style: GoogleFonts.orbitron(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: GoogleFonts.orbitron(color: const Color(0xFF00FF66))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getPage(_currentIndex),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
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
                          color: isSelected ? const Color(0xFF00C851) : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
