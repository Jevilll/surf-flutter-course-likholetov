import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_icons.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/widget/button/button_svg_icon.dart';
import 'package:places/ui/widget/image_preview.dart';
import 'package:places/utils/common.dart';

/// Виджет карточки достопримечательности.
class SightCard extends StatelessWidget {
  final Sight sight;
  final CardType type;

  const SightCard.interesting(this.sight, {
    Key? key,
  })
      : type = CardType.interesting,
        super(key: key);

  const SightCard.toVisit(this.sight, {
    Key? key,
  })
      : type = CardType.toVisit,
        super(key: key);

  const SightCard.visited(this.sight, {
    Key? key,
  })
      : type = CardType.visited,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImagePreview(
                      imgUrl: sight.image,
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Text(
                        sight.type.name,
                        style: AppTextStyles.smallBold
                            .copyWith(color: theme.colorScheme.white),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: CardButtons(type),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          sight.name,
                          maxLines: 2,
                          style: theme.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TimeToVisitText(type, sight),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: double.infinity,
                        child: Text(
                          sight.workingHours,
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
  final Sight sight;

  const TimeToVisitText(this.type, this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return sight.timeToVisit.isEmpty || type == CardType.interesting
        ? const SizedBox.shrink()
        : Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      height: 28,
      width: double.infinity,
      child: Text(
        sight.timeToVisit,
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
class CardButtons extends StatelessWidget {
  final CardType type;

  const CardButtons(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        late final Widget result;
        switch (type) {
          case CardType.interesting:
            result = ButtonSvgIcon(
              icon: AppIcons.heart,
              onPressed: () {
                logger.i('Нажатие на кнопку heart');
              },
            );
            break;
          case CardType.toVisit:
            result = const ToVisitButtons();
            break;
          case CardType.visited:
            result = const VisitedButtons();
            break;
        }

        return result;
      },
    );
  }
}

/// Кнопки мест к посящению.
class ToVisitButtons extends StatelessWidget {
  const ToVisitButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonSvgIcon(
          icon: AppIcons.calendar,
          onPressed: () {
            logger.i('Нажатие на кнопку calendar');
          },
        ),
        ButtonSvgIcon(
          icon: AppIcons.close,
          onPressed: () {
            logger.i('Нажатие на кнопку close');
          },
        ),
      ],
    );
  }
}

/// Кнопки посещенных мест.
class VisitedButtons extends StatelessWidget {
  const VisitedButtons({Key? key}) : super(key: key);

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
        const SizedBox(
          width: 16,
        ),
        ButtonSvgIcon(
          icon: AppIcons.close,
          onPressed: () {
            logger.i('Нажатие на кнопку close');
          },
        ),
      ],
    );
  }
}

/// Тип карточки.
enum CardType { interesting, toVisit, visited }