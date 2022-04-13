import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/utils/common.dart';

/// Экран настроек.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.settings,
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                AppStrings.darkTheme,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
              ),
              trailing: CupertinoSwitch(
                trackColor: AppColors.inactiveBlack,
                value: value,
                onChanged: (currentValue) {
                  themeNotifier.notifyListeners();
                },
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                AppStrings.watchTutorial,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
              ),
              trailing: ButtonSvgIcon(
                icon: AppIcons.info,
                onPressed: () {},
                color: theme.colorScheme.green,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
