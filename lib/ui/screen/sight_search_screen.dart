import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
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
  late final  ValueChanged<String>? _onChanged;
  final List<String> _history = [];
  bool _showProgress = false;
  List<Sight> _searchedSights = [];
  late TextEditingController _controller;
  Timer? _debounce;


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _onChanged = (value) => setState(() {
      _onSearchChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.listOfInterestingPlaces,
        leading: ButtonSvgIcon(
          icon: AppIcons.arrow,
          color: Theme.of(context).colorScheme.main,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottomWidget: SearchBar(
          controller: _controller,
          onChanged: _onChanged,
          suffix: _controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _controller.clear();
                        _searchedSights.clear();
                      });
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
      body: _showProgress
          ? Center(
              child: GradientProgressIndicator(
                radius: 20,
                gradientColors: [AppColors.secondary2, theme.colorScheme.inactive],
                gradientStops: const [
                  0.2,
                  0.8,
                ],
                duration: 1,
                strokeWidth: 4,
                child: const SizedBox(),
              ),
            )
          : _searchedSights.isEmpty && _controller.text.isNotEmpty
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
                                  SightDetails(_searchedSights[index]),
                            ),
                          );
                        },
                        leading: ImagePreview(
                          imgUrl: _searchedSights[index].image,
                          height: 56,
                          width: 56,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: HighlightText(
                          _searchedSights[index].name,
                          _controller.text,
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

  void _onSearchChanged(String value) {
    if (value.isNotEmpty) {
      if (!_showProgress) {
        setState(() {
          _showProgress = true;
        });
      }
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        final suggestions = mocks.where((sight) {
          final name = sight.name.toLowerCase();
          final input = value.toLowerCase();

          return input.isNotEmpty && name.contains(input);
        }).toList();

        _history.add(value);

        setState(() {
          _searchedSights = suggestions;
          _showProgress = false;
        });
      });
    } else {
      _searchedSights.clear();
    }
  }
}

/// Enum состояния экрана.
enum ScreenState {
  searchResult,
  progress,
  nothingFound,
  history,
}

/// Виджет истории поиска.
class History extends StatefulWidget {
  final ValueChanged<String> _onHistoryTap;
  final List<String> _history;

  const History(this._history, this._onHistoryTap, {Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return widget._history.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
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
                  itemCount: widget._history.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      widget._onHistoryTap(widget._history[index]);
                    },
                    title: Text(
                      widget._history[index],
                      style: theme.textTheme.bodyLarge,
                    ),
                    trailing: ButtonSvgIcon(
                      icon: AppIcons.delete,
                      color: theme.colorScheme.secondary2,
                      onPressed: () {
                        setState(() {
                          widget._history.removeAt(index);
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
                            widget._history.clear();
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
            ),
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

/// Виджет отображения текста с выделением поисковой строки.
class HighlightText extends StatefulWidget {
  final String _text;
  final String _substring;

  const HighlightText(this._text, this._substring, {Key? key})
      : super(key: key);

  @override
  State<HighlightText> createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final startIndex =
        widget._text.toLowerCase().indexOf(widget._substring.toLowerCase());
    final endIndex = startIndex + widget._substring.length;

    final textBefore = widget._text.substring(0, startIndex);
    final textHighlight = widget._text.substring(startIndex, endIndex);
    final textAfter = widget._text.substring(endIndex, widget._text.length);

    return RichText(
      text: TextSpan(
        children: [
          _normalSpan(theme, textBefore),
          _highlightSpan(theme, textHighlight),
          _normalSpan(theme, textAfter),
        ],
      ),
    );
  }

  TextSpan _highlightSpan(ThemeData theme, String? content) {
    return TextSpan(
      text: content,
      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
    );
  }

  TextSpan _normalSpan(ThemeData theme, String? content) {
    return TextSpan(text: content, style: theme.textTheme.bodyLarge);
  }
}
