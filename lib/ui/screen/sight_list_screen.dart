import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_sizes.dart';
import 'package:places/res/app_strings.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(AppSizes.appBarHeight),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: mocks.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) => SightCard.interesting(mocks[index]),
      ),
    );
  }
}

/// Виджет апп бара.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  @override
  Size get preferredSize => Size(double.infinity, height);

  const CustomAppBar(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.appName,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      toolbarHeight: height,
    );
  }
}
