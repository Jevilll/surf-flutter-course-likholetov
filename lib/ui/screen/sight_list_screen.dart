import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/sight_card.dart';

/// Экран списка достопримечательностей.
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: isPortrait ? 140 : 56,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: isPortrait
                  ? const EdgeInsets.all(16)
                  : const EdgeInsets.only(
                      left: 34,
                      top: 16,
                      right: 34,
                      bottom: 16,
                    ),
              expandedTitleScale: 1.8,
              centerTitle: isPortrait,
              title: Text(
                AppStrings.listOfInterestingPlacesTwoLines,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: isPortrait
                  ? const EdgeInsets.only(bottom: 16)
                  : const EdgeInsets.only(left: 18, right: 18, bottom: 16),
              child: SearchBar(
                isReadOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<SightSearchScreen>(
                      builder: <BuildContext>(context) =>
                          const SightSearchScreen(),
                    ),
                  );
                },
                suffix: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<FiltersScreen>(
                        builder: <BuildContext>(context) =>
                            const FiltersScreen(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    AppIcons.filter,
                    color: theme.colorScheme.green,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: isPortrait
                ? const EdgeInsets.only(left: 16, top: 16, right: 16)
                : const EdgeInsets.only(left: 34, top: 16, right: 34),
            sliver: isPortrait
                ? _SightsListPortrait(
                    sights: mocks,
                  )
                : _SightsListLandscape(
                    sights: mocks,
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 48,
        width: 177,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [AppColors.fabGreen, AppColors.darkGreen],
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute<AddSightScreen>(
                builder: <BuildContext>(context) => const AddSightScreen(),
              ),
            );
            setState(() {});
          },
          label: const Text(AppStrings.newPlace),
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: SvgPicture.asset(
            AppIcons.plus,
            color: AppColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/// Список достопримечательностей при портретной ориентации.
class _SightsListPortrait extends StatelessWidget {
  final List<Sight> sights;

  const _SightsListPortrait({required this.sights, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SightCard(
              sights[index],
            ),
          );
        },
        childCount: sights.length,
      ),
    );
  }
}

/// Список достопримечательностей при альбомной ориентации.
class _SightsListLandscape extends StatelessWidget {
  final List<Sight> sights;

  const _SightsListLandscape({required this.sights, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SightCard(
              sights[index],
            ),
          );
        },
        childCount: sights.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 36,
      ),
    );
  }
}
