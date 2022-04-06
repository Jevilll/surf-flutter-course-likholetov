import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_text_styles.dart';
import 'package:places/res/app_themes.dart';
import 'package:places/ui/utils.dart';

/// Виджет карточки достопримечательности.
class SightCard extends StatelessWidget {
  final Sight sight;
  final CardType type;

  const SightCard.interesting(
    this.sight, {
    Key? key,
  })  : type = CardType.interesting,
        super(key: key);

  const SightCard.toVisit(
    this.sight, {
    Key? key,
  })  : type = CardType.toVisit,
        super(key: key);

  const SightCard.visited(
    this.sight, {
    Key? key,
  })  : type = CardType.visited,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  sight.image.load(fit: BoxFit.cover),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(
                      sight.type.name,
                      style: AppTextStyles.smallBold
                          .copyWith(color: Theme.of(context).colorScheme.white),
                    ),
                  ),
                  Positioned(
                    top: 19,
                    right: 18,
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
                        style: Theme.of(context).textTheme.bodyMedium,
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
                          color: Theme.of(context).colorScheme.secondary2,
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
                    ? Theme.of(context).colorScheme.green
                    : Theme.of(context).secondaryHeaderColor,
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
            result = SvgPicture.asset(
              'assets/icons/heart.svg',
              color: AppColors.white,
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
        SvgPicture.asset(
          'assets/icons/calendar.svg',
          color: AppColors.white,
        ),
        const SizedBox(
          width: 16,
        ),
        SvgPicture.asset(
          'assets/icons/close.svg',
          color: AppColors.white,
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
        SvgPicture.asset(
          'assets/icons/share.svg',
          color: AppColors.white,
        ),
        const SizedBox(
          width: 16,
        ),
        SvgPicture.asset(
          'assets/icons/close.svg',
          color: AppColors.white,
        ),
      ],
    );
  }
}

/// Тип карточки.
enum CardType { interesting, toVisit, visited }
