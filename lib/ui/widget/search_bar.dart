import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_themes.dart';

/// Виджет поисковой строки.
class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? controller;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  @override
  Size get preferredSize => const Size.fromHeight(40);

  const SearchBar({
    this.controller,
    this.isReadOnly = false,
    this.onTap,
    this.suffix,
    this.onEditingComplete,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 40,
      child: TextField(
        controller: widget.controller,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        readOnly: widget.isReadOnly,
        autofocus: true,
        cursorColor: theme.colorScheme.main,
        textInputAction: TextInputAction.done,
        onChanged: widget.onChanged,
        onSubmitted: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          hintText: AppStrings.search,
          contentPadding: const EdgeInsets.all(10.0),
          filled: true,
          fillColor: theme.colorScheme.background2,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.inactiveBlack,
          ),
          enabledBorder: border(theme),
          focusedBorder: border(theme),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset(
              AppIcons.search,
              color: AppColors.inactiveBlack,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: widget.suffix,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder border(ThemeData theme) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: theme.colorScheme.background2),
  );
}
