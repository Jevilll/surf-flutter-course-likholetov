import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/widget/app_bar.dart';
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

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.listOfInterestingPlaces,
        bottomWidget: SearchBar(
          isReadOnly: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<SightSearchScreen>(
                builder: <BuildContext>(context) => const SightSearchScreen(),
              ),
            );
          },
          suffix: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<FiltersScreen>(
                  builder: <BuildContext>(context) => const FiltersScreen(),
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: mocks.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) => SightCard.interesting(mocks[index]),
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
