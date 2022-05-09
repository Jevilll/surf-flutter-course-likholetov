import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/center_content.dart';
import 'package:places/ui/widget/sight_card.dart';

/// Экран избранных мест.
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
                ReorderableDismissibleList(
                  sights: mocksToVisit,
                  type: CardType.toVisit,
                ),
                ReorderableDismissibleList(
                  sights: mocksVisited,
                  type: CardType.visited,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

/// Сортируемый список достопримечательностей,
/// с возможностью удалить элемент путем смахивания.
class ReorderableDismissibleList extends StatefulWidget {
  final List<Sight> sights;
  final CardType type;

  const ReorderableDismissibleList({
    required this.sights,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  State<ReorderableDismissibleList> createState() =>
      _ReorderableDismissibleListState();
}

class _ReorderableDismissibleListState
    extends State<ReorderableDismissibleList> {
  late final CardType _type;

  @override
  void initState() {
    _type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return widget.sights.isNotEmpty
        ? ReorderableListView.builder(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.sights.length,
            itemBuilder: (context, index) {
              final sight = widget.sights[index];

              return Padding(
                key: ObjectKey(sight),
                padding: const EdgeInsets.only(bottom: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ObjectKey(sight),
                    background: const DeleteBackground(),
                    onDismissed: (_) {
                      setState(() {
                        widget.sights.remove(sight);
                      });
                    },
                    child: Container(
                      color: theme.colorScheme.red,
                      child: SightCard(
                        sight,
                        type: _type,
                        onDelete: () {
                          setState(() {
                            widget.sights.remove(sight);
                          });
                        },
                        onDatePick: _putRemainder,
                      ),
                    ),
                  ),
                ),
              );
            },
            onReorder: _reorderData,
          )
        : CenterContent(
            icon: AppIcons.card64,
            title: AppStrings.empty,
            subtitle: _type == CardType.toVisit
                ? AppStrings.emptyToVisit
                : AppStrings.emptyVisited,
          );
  }

  void _reorderData(int oldItem, int newItem) {
    setState(() {
      final items = widget.sights.removeAt(oldItem);
      widget.sights.insert(newItem > oldItem ? newItem - 1 : newItem, items);
    });
  }

  Future<void> _putRemainder() async {
    final now = DateTime.now();
    final dateResult = await showDatePicker(
      context: context,
      locale: const Locale("ru", "RU"),
      helpText: AppStrings.chooseDateOfVisit,
      confirmText: AppStrings.chooseTime,
      cancelText: AppStrings.cancel2,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 360)),
    );
    if (dateResult != null) {
      final timeResult = await showTimePicker(
          context: context,
          helpText: AppStrings.chooseTimeOfVisit,
          cancelText: AppStrings.cancel2,
          confirmText: AppStrings.plan,
          initialTime: TimeOfDay.now(),);
    }
  }
}

/// Виджет заднего фона смахиваемого элемента.
class DeleteBackground extends StatelessWidget {
  const DeleteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.red,
        border: Border.all(
          color: theme.colorScheme.red,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: UnconstrainedBox(
          child: Column(
            children: [
              SvgPicture.asset(
                AppIcons.bucket,
                color: AppColors.white,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                AppStrings.remove,
                style:
                    theme.textTheme.bodySmall?.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
