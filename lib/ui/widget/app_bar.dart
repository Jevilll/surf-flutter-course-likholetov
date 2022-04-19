import 'package:flutter/material.dart';

/// Апп бар приложения.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottomWidget;

  @override
  Size get preferredSize => Size.fromHeight(bottomWidget == null ? kToolbarHeight : kToolbarHeight + 40);

  const CustomAppBar({this.title, this.leading, this.actions, this.bottomWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 72,
      title: title != null ? Text(
        title!,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ) : null,
      leading: leading,
      actions: actions,
      bottom: bottomWidget,
    );
  }
}