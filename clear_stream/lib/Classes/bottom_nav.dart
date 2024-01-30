import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed, // Ensures items are fixed in size
      items: [
        _buildBottomNavigationBarItem(Icons.book, 'Tab 1'),
        _buildBottomNavigationBarItem(Icons.settings, 'Tab 2'),
        _buildBottomNavigationBarItem(Icons.location_city, 'Tab 3'),
        // Add more items as needed
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
