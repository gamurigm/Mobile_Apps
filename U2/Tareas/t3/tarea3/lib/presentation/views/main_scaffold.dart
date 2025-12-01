import 'package:flutter/material.dart';
// Minimal scaffold for bottom navigation — no extra imports needed
import 'home_page.dart';
import 'grid_page.dart';
import 'animations_page.dart';
import '../themes/app_theme.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    GridPage(),
    AnimationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Grid'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Animations'),
        ],
        backgroundColor: AppTheme.surfaceColor,
        selectedItemColor: AppTheme.goldColor,
      ),
    );
  }
}
