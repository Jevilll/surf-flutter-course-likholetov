import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/ui/screen/favorites_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/place_list_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';

/// Экран разводной.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final scenes = [
    const PlaceListScreen(),
    const FiltersScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: scenes,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: _tabController.animateTo,
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  BottomNavigationBarItem _getItem(
    BuildContext context, {
    required String icon,
    required String activeIcon,
  }) {
    final theme = Theme.of(context);

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: theme.primaryColor,
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        color: theme.primaryColor,
      ),
      label: '',
    );
  }
}
