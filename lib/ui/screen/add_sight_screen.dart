import 'package:flutter/material.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/custom_text_field.dart';

/// Экран добавления достопримечательности.
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusNodeDescription = FocusNode();

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.newPlace,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ButtonWithoutBorders(
            title: AppStrings.cancel,
            height: 32,
            width: 82,
            color: theme.colorScheme.green,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.category,
                  style: AppTextStyles.superSmall,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  AppStrings.notChosen,
                  style: theme.textTheme.bodySmall,
                ),
                trailing: ButtonSvgIcon(
                  icon: AppIcons.view,
                  onPressed: () {},
                  color: theme.colorScheme.main,
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const EditableItem(
                name: AppStrings.name,
                textInputAction: TextInputAction.next,
              ),
              Row(
                children: [
                  const Expanded(
                    child: EditableItem(
                      name: AppStrings.latitude,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: EditableItem(
                      name: AppStrings.longitude,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(focusNodeDescription),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: UnconstrainedBox(
                  child: ButtonWithoutBorders(
                    title: AppStrings.indicateOnMap,
                    onPressed: () {},
                    width: 130,
                    height: 20,
                    color: theme.colorScheme.green,
                  ),
                ),
              ),
              EditableItem(
                name: AppStrings.description,
                focusNode: focusNodeDescription,
                maxLines: 3,
                hint: AppStrings.enterText,
              ),

              const ButtonRounded(
                title: AppStrings.create,
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Виджет радактируемого поля.
class EditableItem extends StatefulWidget {
  final String name;
  final FocusNode? focusNode;
  final int maxLines;
  final String? hint;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;

  const EditableItem({
    required this.name,
    this.focusNode,
    this.maxLines = 1,
    this.hint,
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
    Key? key,
  }) : super(key: key);

  @override
  State<EditableItem> createState() => _EditableItemState();
}

class _EditableItemState extends State<EditableItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.name,
            style: AppTextStyles.superSmall,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextField(
          focusNode: widget.focusNode,
          maxLines: widget.maxLines,
          hint: widget.hint,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          // controller: controller,
        ),
      ],
    );
  }
}
