import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        surfaceTintColor: Colors.white,
        indicatorColor: Colors.white,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      child: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'Home',
            selectedIcon: Icon(Icons.home, size: 30),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, size: 30),
            label: 'Profile',
            selectedIcon: Icon(Icons.person, size: 30),
          )
        ],
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 1,
        animationDuration: const Duration(milliseconds: 1000),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => _selectPage(index),
      ),
    );
  }
}
