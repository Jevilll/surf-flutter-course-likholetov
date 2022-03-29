import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_text_styles.dart';

/// Виджет карточки достопримечательности.
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 96,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(
                      sight.type.name,
                      style: AppTextStyles.smallBold,
                    ),
                  ),
                  const Positioned(
                    top: 19,
                    right: 18,
                    child: Icon(Icons.heart_broken_outlined),
                  ),
                ],
              ),
            ),
            const SizedBox(width: double.infinity, height: 16,),
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
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: double.infinity,
                        child: const Text(
                          AppStrings.shortDescription,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.small,
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
