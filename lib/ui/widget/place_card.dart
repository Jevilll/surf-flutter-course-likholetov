import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/bottom_sheet/place_details_bottom_sheet.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/image_preview.dart';
import 'package:places/utils/common.dart';

/// Виджет карточки места.
class PlaceCard extends StatelessWidget {
  final Place place;
  final CardType type;
  final String favoriteIcon;
  final VoidCallback? onDelete;
  final VoidCallback? onDatePick;
  final VoidCallback? onFavorite;

  const PlaceCard(
    this.place, {
    this.onDelete,
    this.onDatePick,
    this.onFavorite,
    this.type = CardType.interesting,
    this.favoriteIcon = AppIcons.heart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: () {
            showDetails(place.id, context);
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImagePreview(
                      imgUrl: place.urls[0],
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Text(
                        place.type.name,
                        style: AppTextStyles.smallBold
                            .copyWith(color: theme.colorScheme.white),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: CardButtons(
                        type,
                        onDelete: onDelete,
                        onDatePick: onDatePick,
                        onFavorite: onFavorite,
                        favoriteIcon: place.isFavorite
                            ? AppIcons.heartFull
                            : AppIcons.heart,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: theme.colorScheme.background2,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          place.name,
                          maxLines: 2,
                          style: theme.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TimeToVisitText(type, place),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: double.infinity,
                        child: Text(
                          place.workingHours,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.small.copyWith(
                            color: theme.colorScheme.secondary2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Виджет текста, зависящик от типа карточки [CardType].
class TimeToVisitText extends StatelessWidget {
  final CardType type;
  final Place place;

  const TimeToVisitText(this.type, this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return place.timeToVisit.isEmpty || type == CardType.interesting
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            height: 28,
            width: double.infinity,
            child: Text(
              place.timeToVisit,
              style: AppTextStyles.small.copyWith(
                color: type == CardType.toVisit
                    ? theme.colorScheme.green
                    : theme.secondaryHeaderColor,
              ),
              textAlign: TextAlign.left,
            ),
          );
  }
}

/// Виджет отображения кнопок, зависящик от типа карточки [CardType].
class CardButtons extends StatefulWidget {
  final CardType type;
  final VoidCallback? onDelete;
  final VoidCallback? onDatePick;
  final VoidCallback? onFavorite;
  String favoriteIcon;

  CardButtons(
    this.type, {
    this.onDelete,
    this.onDatePick,
    this.onFavorite,
    required this.favoriteIcon,
    Key? key,
  }) : super(key: key);

  @override
  State<CardButtons> createState() => _CardButtonsState();
}

class _CardButtonsState extends State<CardButtons> {
  late String _favoriteIcon;

  @override
  Widget build(BuildContext context) {
    _favoriteIcon = widget.favoriteIcon;

    return Builder(
      builder: (context) {
        late final Widget result;
        switch (widget.type) {
          case CardType.interesting:
            result = ButtonSvgIcon(
              icon: _favoriteIcon,
              onPressed: () {
                widget.onFavorite?.call();
              },
            );
            break;
          case CardType.toVisit:
            result = ToVisitButtons(
              onDelete: widget.onDelete,
              onDatePick: widget.onDatePick,
            );
            break;
          case CardType.visited:
            result = VisitedButtons(
              onDelete: widget.onDelete,
            );
            break;
        }

        return result;
      },
    );
  }
}

/// Кнопки мест к посящению.
class ToVisitButtons extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDatePick;

  const ToVisitButtons({this.onDelete, this.onDatePick, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonSvgIcon(
          icon: AppIcons.calendar,
          onPressed: onDatePick,
        ),
        ButtonSvgIcon(
          icon: AppIcons.close,
          onPressed: onDelete,
        ),
      ],
    );
  }
}

/// Кнопки посещенных мест.
class VisitedButtons extends StatelessWidget {
  final VoidCallback? onDelete;

  const VisitedButtons({this.onDelete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonSvgIcon(
          icon: AppIcons.share,
          onPressed: () {
            logger.i('Нажатие на кнопку share');
          },
        ),
        ButtonSvgIcon(
          icon: AppIcons.close,
          onPressed: onDelete,
        ),
      ],
    );
  }
}

/// Тип карточки.
enum CardType { interesting, toVisit, visited }
