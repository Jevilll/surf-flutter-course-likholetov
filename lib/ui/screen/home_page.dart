import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_details.dart';
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
    SightDetails(mocks[0]),
    const VisitingScreen(),
    SightDetails(mocks[1]),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scenes[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          context.navSvgItem(
            icon: 'assets/icons/list.svg',
            activeIcon: 'assets/icons/list_full.svg',
          ),
          context.navSvgItem(
            icon: 'assets/icons/map.svg',
            activeIcon: 'assets/icons/map_full.svg',
          ),
          context.navSvgItem(
            icon: 'assets/icons/heart.svg',
            activeIcon: 'assets/icons/heart_full.svg',
          ),
          context.navSvgItem(
            icon: 'assets/icons/settings.svg',
            activeIcon: 'assets/icons/settings_full.svg',
          ),
        ],
      ),
    );
  }
}

extension NavigationBarItem on BuildContext {
  BottomNavigationBarItem navSvgItem({required String icon, required String activeIcon}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: Theme.of(this).primaryColor,
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        color: Theme.of(this).primaryColor,
      ),
      label: '',
    );
  }
}
