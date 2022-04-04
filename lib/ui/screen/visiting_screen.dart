import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Экран избранных мест.
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.favorites,
            style: AppTextStyles.subtitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors.background,
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.whiteSecondary,
              ),
              labelStyle: AppTextStyles.smallBold,
              unselectedLabelColor: AppColors.whiteInactiveBlack,
              tabs: const [
                Tab(
                  text: AppStrings.wantToVisit,
                ),
                Tab(
                  text: AppStrings.visited,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SightCard.toVisit(mocks[0]),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SightCard.visited(mocks[1]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
