import 'package:flutter/material.dart';

/// Виджет элемента настроек.
class TextWithRightView extends StatelessWidget {
  final String text;
  final Widget child;

  const TextWithRightView(this.text, {required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        child,
      ],
    );
  }
}
