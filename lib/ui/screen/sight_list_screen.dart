import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';

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
      appBar: AppBar(
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF252849),
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: mocks.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) => SightCard(mocks[index]),
      ),
    );
  }
}
