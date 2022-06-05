import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/interactor/places_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/position.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/screen/place_type_selector_screen.dart';
import 'package:places/ui/widget/app_bar.dart';
import 'package:places/ui/widget/button/button_rounded.dart';
import 'package:places/ui/widget/button/button_without_borders.dart';
import 'package:places/ui/widget/custom_text_field.dart';
import 'package:places/ui/widget/photo_dialog_picker.dart';
import 'package:provider/provider.dart';

/// Экран добавления нового места.
class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  late final TextEditingController _controllerName;
  late final TextEditingController _controllerLat;
  late final TextEditingController _controllerLong;
  late final TextEditingController _controllerDescription;
  final _focusNodeLat = FocusNode();
  final _focusNodeLong = FocusNode();
  final _focusNodeDescription = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _photos = ['add'];
  Type? _placeType;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerLat = TextEditingController();
    _controllerLong = TextEditingController();
    _controllerDescription = TextEditingController();
    _controllerName.addListener(() => setState(() {}));
    _controllerLat.addListener(() => setState(() {}));
    _controllerLong.addListener(() => setState(() {}));
    _controllerDescription.addListener(() => setState(() {}));
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    height: 72,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _photos.length,
                      itemBuilder: (context, index) => index != 0
                          ? _PhotoCard(
                              photoAsset: _photos[index],
                              onDelete: () {
                                setState(() {
                                  _photos.removeAt(index);
                                });
                              },
                            )
                          : AddPhotoButton(
                              onPressed: () {
                                setState(() {
                                  addPhoto(context);
                                });
                              },
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.category.toUpperCase(),
                        style: AppTextStyles.superSmall,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        final result = await Navigator.push<Type>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceTypeSelectorScreen(
                              type: _placeType,
                            ),
                          ),
                        );
                        setState(() {
                          _placeType = result ?? _placeType;
                        });
                      },
                      leading: Text(
                        _placeType != null
                            ? _placeType!.name
                            : AppStrings.notChosen,
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: SvgPicture.asset(
                        AppIcons.view,
                        color: theme.colorScheme.main,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 16,
                    endIndent: 16,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _EditableItem(
                      name: AppStrings.name.toUpperCase(),
                      textInputAction: TextInputAction.next,
                      controller: _controllerName,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_focusNodeLat),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _EditableItem(
                            name: AppStrings.latitude.toUpperCase(),
                            controller: _controllerLat,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            focusNode: _focusNodeLat,
                            validator: (value) {
                              if (!_isNumeric(value)) {
                                return '';
                              }

                              return null;
                            },
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNodeLong),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: _EditableItem(
                            name: AppStrings.longitude.toUpperCase(),
                            controller: _controllerLong,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            focusNode: _focusNodeLong,
                            validator: (value) {
                              if (!_isNumeric(value)) {
                                return '';
                              }

                              return null;
                            },
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNodeDescription),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _EditableItem(
                      name: AppStrings.description.toUpperCase(),
                      controller: _controllerDescription,
                      focusNode: _focusNodeDescription,
                      maxLines: 3,
                      hint: AppStrings.enterText,
                    ),
                  ),
                  // const Spacer(),
                  ButtonRounded(
                    title: AppStrings.create.toUpperCase(),
                    onPressed: _isButtonEnabled()
                        ? () {
                            context.read<PlacesInteractor>().addPlace(Place(
                                  id: 0,
                                  name: _controllerName.text,
                                  description: _controllerDescription.text,
                                  type: _placeType!,
                                  urls: [],
                                  position: Position(
                                    double.tryParse(_controllerLat.text) ?? 0,
                                    double.tryParse(_controllerLong.text) ?? 0,
                                  ),
                                ));
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(AppStrings.placeAdded),
                              ),
                            );
                          }
                        : null,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isNumeric(String? s) {
    if (s == null) {
      return false;
    }

    return double.tryParse(s) != null;
  }

  bool _isButtonEnabled() {
    return _controllerName.text.isNotEmpty &&
        _controllerLat.text.isNotEmpty &&
        _controllerLong.text.isNotEmpty &&
        _controllerDescription.text.isNotEmpty &&
        _placeType != null &&
        _formKey.currentState!.validate();
  }
}

/// Виджет радактируемого поля.
class _EditableItem extends StatefulWidget {
  final String name;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;
  final String? hint;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final TextInputType? textInputType;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  const _EditableItem({
    required this.name,
    this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.hint,
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
    this.textInputType,
    this.onFieldSubmitted,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<_EditableItem> createState() => _EditableItemState();
}

class _EditableItemState extends State<_EditableItem> {
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
          validator: widget.validator,
        ),
      ],
    );
  }
}

/// Карточка добавленной фотограции.
class _PhotoCard extends StatelessWidget {
  final String photoAsset;
  final VoidCallback onDelete;

  const _PhotoCard({
    required this.photoAsset,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          UnconstrainedBox(
            child: GestureDetector(
              onTap: onDelete,
              child: Dismissible(
                direction: DismissDirection.up,
                key: UniqueKey(),
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: SvgPicture.asset(
                      AppIcons.view,
                      color: theme.colorScheme.main,
                    ),
                  ),
                ),
                onDismissed: (_) {
                  onDelete.call();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    photoAsset,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IgnorePointer(
              child: SvgPicture.asset(
                AppIcons.clear,
                height: 24,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Кнопка добавления фотографии.
class AddPhotoButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddPhotoButton({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        width: 72,
        height: 72,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 2.0,
              color: theme.colorScheme.green.withOpacity(0.5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: SvgPicture.asset(
            AppIcons.plus,
            height: 40,
            color: theme.colorScheme.green,
          ),
        ),
      ),
    );
  }
}
