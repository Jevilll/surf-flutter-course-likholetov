import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/bottom_sheet/place_details_bottom_sheet.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/center_content.dart';
import 'package:places/ui/widget/image_preview.dart';
import 'package:places/ui/widget/progress.dart';
import 'package:places/ui/widget/search_bar.dart';

/// Экран поиска мест.
class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  late final SearchInteractor _interactor;
  late final ValueChanged<String>? _onChanged;
  final List<String> _history = [];
  bool _showProgress = false;
  List<Place> _searchedPlaces = [];
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _interactor = SearchInteractor();
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
                        _searchedPlaces.clear();
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
          ? const Center(
              child: GradientProgress(),
            )
          : _searchedPlaces.isEmpty && _controller.text.isNotEmpty
              ? const CenterContent(
                  icon: AppIcons.search64,
                  title: AppStrings.nothingFound,
                  subtitle: AppStrings.tryToChangeSearchParameters,
                )
              : _searchedPlaces.isEmpty && _controller.text.isEmpty
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
                      itemCount: _searchedPlaces.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          showDetails(_searchedPlaces[index].id, context);
                        },
                        leading: ImagePreview(
                          imgUrl: _searchedPlaces[index].urls[0],
                          height: 56,
                          width: 56,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: HighlightText(
                          _searchedPlaces[index].name,
                          _controller.text,
                        ),
                        subtitle: Text(
                          _searchedPlaces[index].type.name,
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
        final suggestions = mocks.where((place) {
          final name = place.name.toLowerCase();
          final input = value.toLowerCase();

          return input.isNotEmpty && name.contains(input);
        }).toList();

        _history.add(value);

        setState(() {
          _searchedPlaces = suggestions;
          _showProgress = false;
        });
      });
    } else {
      _searchedPlaces.clear();
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

  const History(this._history, this._onHistoryTap, {Key? key})
      : super(key: key);

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
                      AppStrings.youSearched.toUpperCase(),
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
