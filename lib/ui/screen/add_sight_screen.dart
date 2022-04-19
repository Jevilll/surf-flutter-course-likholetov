import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/sight_type_selector_screen.dart';
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
  final _controllerName = TextEditingController();
  final _controllerLat = TextEditingController();
  final _controllerLong = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _focusNodeLat = FocusNode();
  final _focusNodeLong = FocusNode();
  final _focusNodeDescription = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String? _category = AppStrings.notChosen;

  @override
  void initState() {
    _controllerName.addListener(() => setState(() {}));
    _controllerLat.addListener(() => setState(() {}));
    _controllerLong.addListener(() => setState(() {}));
    _controllerDescription.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerLat.dispose();
    _controllerLong.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.category.toUpperCase(),
                        style: AppTextStyles.superSmall,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        final result = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SightTypeSelectorScreen(),
                          ),
                        );
                        setState(() {
                          _category = result;
                        });
                      },
                      leading: Text(
                        _category ?? AppStrings.notChosen,
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: SvgPicture.asset(
                        AppIcons.view,
                        color: theme.colorScheme.main,
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    EditableItem(
                      name: AppStrings.name,
                      textInputAction: TextInputAction.next,
                      controller: _controllerName,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: EditableItem(
                            name: AppStrings.latitude,
                            controller: _controllerLat,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            focusNode: _focusNodeLat,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: EditableItem(
                            name: AppStrings.longitude,
                            controller: _controllerLong,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            focusNode: _focusNodeLong,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNodeDescription),
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
                      controller: _controllerDescription,
                      focusNode: _focusNodeDescription,
                      maxLines: 3,
                      hint: AppStrings.enterText,
                    ),
                    const Spacer(),
                    ButtonRounded(
                      title: AppStrings.create,
                      onPressed: _isButtonEnabled()
                          ? () {
                              _formKey.currentState!.validate();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isButtonEnabled() {
    return _controllerName.text.isNotEmpty &&
        _controllerLat.text.isNotEmpty &&
        _controllerLong.text.isNotEmpty &&
        _controllerDescription.text.isNotEmpty;
  }
}

/// Виджет радактируемого поля.
class EditableItem extends StatefulWidget {
  final String name;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;
  final String? hint;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final TextInputType? textInputType;
  final ValueChanged<String>? onFieldSubmitted;

  const EditableItem({
    required this.name,
    this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.hint,
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
    this.textInputType,
    this.onFieldSubmitted,
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
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          textInputType: widget.textInputType,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: (value) {
            if(!isNumeric(value))  {
              return '';
            }
          },
        ),
      ],
    );
  }
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }

    return double.tryParse(s) != null;
  }
}
