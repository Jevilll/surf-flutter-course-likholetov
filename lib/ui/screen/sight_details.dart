import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/styles.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.amber,
            child: const SizedBox(
              height: 360,
              width: double.infinity,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            width: double.infinity,
            child: Text(
              sight.name,
              style: title,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 2, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  sight.type.name,
                  style: text,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'закрыто до 09:00', // todo заглушка для дизайна
                  style: small,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            child: Text(
              sight.details,
              style: small,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
            height: 48,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: whiteGreen,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: const Center(
              child: Text(
                'Построить маршрут',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
            height: 1,
            width: double.infinity,
            color: whiteInactiveBlack,
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            width: double.infinity,
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 16, top: 8, right: 16, bottom: 16,),
                    width: double.infinity,
                    child: const Center(
                      child: Text('Запланировать', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 16, top: 8, right: 16, bottom: 16,),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'В избранное',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
