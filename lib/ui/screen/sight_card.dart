import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/strings.dart';
import 'package:places/res/styles.dart';

/// Виджет карточки достопримечательности.
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                    sight.name,
                    style: smallBold,
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
          Container(
            color: background,
            height: 92,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      sight.details,
                      maxLines: 2,
                      style: text,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: double.infinity,
                    child: const Text(
                      shortDescription,
                      textAlign: TextAlign.left,
                      style: small,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
