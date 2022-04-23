import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';

/// Экран выбора типа достопримечательности.
class SightTypeSelectorScreen extends StatefulWidget {
  final Type? type;
  const SightTypeSelectorScreen({this.type, Key? key}) : super(key: key);

  @override
  State<SightTypeSelectorScreen> createState() =>
      _SightTypeSelectorScreenState();
}

class _SightTypeSelectorScreenState extends State<SightTypeSelectorScreen> {
  final _types = Type.values;
  int? _selectedIndex;

  @override
  void initState() {
   _selectedIndex = widget.type != null ? _types.indexOf(widget.type!) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.category,
        leading: ButtonSvgIcon(
          icon: AppIcons.arrow,
          color: theme.colorScheme.main,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _types.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _types[index].name,
                  style: theme.textTheme.bodyLarge,
                ),
                trailing: _selectedIndex == index
                    ? SvgPicture.asset(
                  AppIcons.tick,
                  color: theme.colorScheme.green,
                )
                    : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ButtonRounded(
              title: AppStrings.save,
              onPressed: _selectedIndex != null ? () {
                Navigator.pop(context, _types[_selectedIndex!]);
              } : null,
            ),
          ),
        ],
      ),
    );
  }
}
