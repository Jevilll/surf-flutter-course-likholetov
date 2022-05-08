import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';

/// Команда открыть диалог выбора фотографии.
Future<void> addPhoto(BuildContext context) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (_) => const _PhotoDialogPicker(),
  );
}

/// Диалог выбора фотографии.
class _PhotoDialogPicker extends StatelessWidget {
  const _PhotoDialogPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            AppStrings.cancel.toUpperCase(),
            style: theme.textTheme.button
                ?.copyWith(color: theme.colorScheme.green),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          _ActionItem(
            icon: AppIcons.camera,
            text: AppStrings.clear,
            onPressed: () {},
          ),
          _ActionItem(
            icon: AppIcons.photo,
            text: AppStrings.photo,
            onPressed: () {},
          ),
          _ActionItem(
            icon: AppIcons.file,
            text: AppStrings.file,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/// Элемент диалога.
class _ActionItem extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;

  const _ActionItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.background,
      child: CupertinoActionSheetAction(
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: theme.colorScheme.secondary2,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.secondary2),
            ),
          ],
        ),
      ),
    );
  }
}
