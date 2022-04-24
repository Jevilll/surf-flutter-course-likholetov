import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/nothing_found.dart';
import 'package:places/ui/widget/sight_card.dart';

/// Экран избранных мест.
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  final List<Sight> _toVisit = List.from(mocks);
  final List<Sight> _visited = List.from(mocks);
  final GlobalKey<AnimatedListState> _toVisitKey = GlobalKey();
  final GlobalKey<AnimatedListState> _visitedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.favorites),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: theme.cardColor,
            ),
            child: const TabBar(
              tabs: [
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
                if (_toVisit.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AnimatedList(
                      key: _toVisitKey,
                      initialItemCount: _toVisit.length,
                      itemBuilder: (_, index, animation) {
                        return SightCard(
                          _toVisit[index],
                          type: CardType.toVisit,
                          onDelete: () {
                            _removeItem(
                              index,
                              _toVisitKey,
                              _toVisit[index],
                              CardType.toVisit,
                            );
                            setState(() {
                              _toVisit.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  )
                else
                  const NothingFound(
                    icon: AppIcons.card64,
                    title: AppStrings.empty,
                    subtitle: AppStrings.emptyToVisit,
                  ),
                if (_visited.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AnimatedList(
                      key: _visitedKey,
                      initialItemCount: _visited.length,
                      itemBuilder: (_, index, animation) {
                        return SightCard(
                          _visited[index],
                          type: CardType.visited,
                          onDelete: () {
                            _removeItem(
                              index,
                              _visitedKey,
                              _visited[index],
                              CardType.visited,
                            );
                            setState(() {
                              _visited.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  )
                else
                  const NothingFound(
                    icon: AppIcons.go64,
                    title: AppStrings.empty,
                    subtitle: AppStrings.emptyVisited,
                  ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _removeItem(
    int index,
    GlobalKey<AnimatedListState> key,
    Sight sight,
    CardType cardType,
  ) {
    key.currentState?.removeItem(
      index,
      (_, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: SightCard(
              sight,
              type: cardType,
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 500),
    );
  }
}
