import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_icons.dart';
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
          _getItem(
            context,
            icon: AppIcons.list,
            activeIcon: AppIcons.listFull,
          ),
          _getItem(
            context,
            icon: AppIcons.map,
            activeIcon: AppIcons.mapFull,
          ),
          _getItem(
            context,
            icon: AppIcons.heart,
            activeIcon: AppIcons.heartFull,
          ),
          _getItem(
            context,
            icon: AppIcons.settings,
            activeIcon: AppIcons.settingsFull,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _getItem(
    BuildContext context, {
    required String icon,
    required String activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        color: Theme.of(context).primaryColor,
      ),
      label: '',
    );
  }
}
