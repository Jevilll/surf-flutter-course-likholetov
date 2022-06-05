import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/on_boarding_screen.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:provider/provider.dart';

/// Экран настроек.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsInteractor _settingsInteractor;

  @override
  void initState() {
    _settingsInteractor = context.read<SettingsInteractor>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.settings),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                AppStrings.darkTheme,
                style: theme.textTheme.bodyLarge,
              ),
              trailing: CupertinoSwitch(
                trackColor: AppColors.inactiveBlack,
                value: value,
                onChanged: (currentValue) {
                  _settingsInteractor.switchTheme();
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
                style: theme.textTheme.bodyLarge,
              ),
              trailing: ButtonSvgIcon(
                icon: AppIcons.info,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<OnBoardingScreen>(
                      builder: <BuildContext>(context) => const OnBoardingScreen(),
                    ),
                  );
                },
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
