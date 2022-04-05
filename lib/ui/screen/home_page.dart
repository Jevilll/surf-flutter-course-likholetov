import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/ui/screen/foo.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

/// Экран разводной.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scenes = [
    const SightListScreen(),
    const Foo(),
    const VisitingScreen(),
    const Foo(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scenes[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.whiteSecondary,
        selectedItemColor: AppColors.whiteMain,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
