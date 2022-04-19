import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/image_preview.dart';
import 'package:places/ui/widget/search_bar.dart';

/// Экран поиска достопримечательностей.
class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final List<String> _history = [];
  List<Sight> _searchedSights = [];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_search);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.listOfInterestingPlaces,
        bottomWidget: SearchBar(
          controller: _controller,
          onEditingComplete: () {
            _history.add(_controller.text);
          },
          suffix: _controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      _controller.clear();
                    },
                    child: SvgPicture.asset(
                      AppIcons.clear,
                      color: theme.colorScheme.main,
                    ),
                  ),
                )
              : null,
        ),
      ),
      body: _searchedSights.isEmpty && _controller.text.isNotEmpty
          ? const NothingFound()
          : _searchedSights.isEmpty && _controller.text.isEmpty
              ? History(_history, (historyElement) {
                  setState(() {
                    _controller
                      ..text = historyElement
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length),
                      );
                  });
                })
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _searchedSights.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<SightDetails>(
                          builder: <BuildContext>(context) =>
                              SightDetails(mocks[index]),
                        ),
                      );
                    },
                    leading: ImagePreview(
                      imgUrl: _searchedSights[index].image,
                      height: 56,
                      width: 56,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      _searchedSights[index].name,
                      style: theme.textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      _searchedSights[index].type.name,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    final suggestions = mocks.where((sight) {
      final name = sight.name;
      final input = _controller.text;

      return input.isNotEmpty && name.contains(input);
    }).toList();

    setState(() => _searchedSights = suggestions);
  }
}

/// Виджет истории поиска.
class History extends StatefulWidget {
  final ValueChanged<String> onHistoryTap;
  final List<String> _history;

  const History(this._history, this.onHistoryTap, {Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<String> _history;

  @override
  void initState() {
    _history = List<String>.from(widget._history);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _history.isNotEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.youSearched,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _history.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                ),
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    widget.onHistoryTap(_history[index]);
                  },
                  title: Text(
                    _history[index],
                    style: theme.textTheme.bodyLarge,
                  ),
                  trailing: ButtonSvgIcon(
                    icon: AppIcons.delete,
                    color: theme.colorScheme.secondary2,
                    onPressed: () {
                      setState(() {
                        _history.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: UnconstrainedBox(
                    child: ButtonWithoutBorders(
                      title: AppStrings.clearHistory,
                      onPressed: () {
                        setState(() {
                          _history.clear();
                        });
                      },
                      width: 141,
                      height: 20,
                      color: theme.colorScheme.green,
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}

/// Виджет сообщения об отсутсвии результата поиска.
class NothingFound extends StatelessWidget {
  const NothingFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.search64,
            color: AppColors.inactiveBlack,
          ),
          Text(
            AppStrings.nothingFound,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: AppColors.inactiveBlack),
          ),
          Text(
            AppStrings.tryToChangeSearchParameters,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppColors.inactiveBlack),
          ),
        ],
      ),
    );
  }
}
