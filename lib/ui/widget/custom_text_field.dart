import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';

/// Виджет ввода текста.
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;
  final String? hint;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;

  const CustomTextField({
    this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.hint,
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: widget.maxLines * 40,
      child: TextFormField(
        controller: _controller,
        cursorColor: theme.colorScheme.main,
        focusNode: widget.focusNode,
        style: theme.textTheme.bodyLarge,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppTextStyles.superSmall,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colorScheme.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: theme.colorScheme.green),
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 20,
            minWidth: 20,
          ),
          contentPadding: const EdgeInsets.all(10.0),
          suffixIcon: _controller.text.isNotEmpty
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
