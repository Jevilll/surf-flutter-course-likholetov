import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    sight.image,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(
                      sight.type.name,
                      style: AppTextStyles.smallBold,
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
              child: Container(
                color: AppColors.background,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          sight.shortDescription,
                          maxLines: 2,
                          style: AppTextStyles.text,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TimeToVisitText(type, sight),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: double.infinity,
                        child: const Text(
                          AppStrings.shortDescription,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.smallSecondary2,
                        ),
                      ),
                    ],
                  ),
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
    return sight.timeToVisit.isEmpty
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            height: 28,
            width: double.infinity,
            child: Text(
              sight.timeToVisit,
              style: type == CardType.toVisit
                  ? AppTextStyles.smallGreen
                  : AppTextStyles.smallSecondary2,
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
            result = const Icon(
              Icons.favorite_outline,
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
      children: const [
        Icon(
          Icons.calendar_month,
          color: AppColors.white,
        ),
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.close,
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
      children: const [
        Icon(
          Icons.share_outlined,
          color: AppColors.white,
        ),
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.close,
          color: AppColors.white,
        ),
      ],
    );
  }
}

/// Тип карточки.
enum CardType { interesting, toVisit, visited }
