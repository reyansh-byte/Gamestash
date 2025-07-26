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
  final TextEditingController _noteController = TextEditingController();

  final List<_NavItemData> _navItems = [
    _NavItemData('assets/home.png', 'Home'),
    _NavItemData('assets/compass.png', 'Discover'),
    _NavItemData('assets/game.png', 'Games'),
    _NavItemData('assets/profile-candidate.png', 'Profile'),
  ];

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildPlaceholderPage('Discover Page');
      case 2:
        return _buildPlaceholderPage('Games Page');
      case 3:
        return _buildPlaceholderPage('Profile Page');
      default:
        return _buildHomePage();
    }
  }

  Widget _buildPlaceholderPage(String title) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.orbitron(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _saveNoteToFirestore() async {
    final note = _noteController.text.trim();
    if (note.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('notes').add({
        'note': note,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _noteController.clear();
      _showDialog('Success', 'Note saved to Firestore.', Colors.greenAccent);
    } catch (e) {
      _showDialog('Error', 'Failed to save note: $e', Colors.redAccent);
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Save a Note',
            style: GoogleFonts.orbitron(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _noteController,
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Type your note here...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveNoteToFirestore,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C851),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Note',
                style: GoogleFonts.orbitron(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
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
