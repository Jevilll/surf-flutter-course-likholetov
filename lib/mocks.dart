import 'dart:math';

import 'package:places/domain/position.dart';
import 'package:places/domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    'лучший отель',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.hotel,
    image:
    'https://dynl.mktgcdn.com/p/AysCZU1TCaImKSFxQhzPq9HiOWjMRz3ywq4h1pYqtII/600x450.jpg',
    timeToVisit: 'Запланировано на 12 окт. 2020',
    workingHours: 'закрыто до 9:00',
  ),
  Sight(
    'Средний ресторан',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.restaurant,
    image:
    'https://media.admagazine.ru/photos/61407d5e9ecf4e1934c46f10/16:9/w_2560%2Cc_limit/IMG_7838.jpg',
  ),
  Sight(
    'Самое особое',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    image:
    'https://gcdn.tomesto.ru/img/place/000/026/236/restoran-osoboe-mesto-v-trehprudnom-pereulke_9940e_full-174438.jpg',
  ),
  Sight(
    'Большой парк',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.park,
    image:
    'https://static5.depositphotos.com/1004999/458/i/600/depositphotos_4582193-stock-photo-beautiful-spring-park.jpg',
  ),
  Sight(
    'Старый музей',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.museum,
    image: 'https://cdn.culture.ru/c/75570.jpg',
  ),
  Sight(
    'Небольшое кафе',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.cafe,
    image:
    'https://gcdn.tomesto.ru/img/place/000/023/404/restoran-corner-cafe-korner-kafe-na-kompozitorskoy-ulitse_bc545_full-317836.jpg',
  ),
];

final List<Sight> mocksToVisit = List.from(mocks);
final List<Sight> mocksVisited = List.from(mocks);
final List<String> _testImages = [
  'assets/test_photos/1.jpg',
  'assets/test_photos/2.jpg',
  'assets/test_photos/3.jpg',
  'assets/test_photos/4.jpg',
  'assets/test_photos/5.jpg',
  'assets/test_photos/6.jpg',
  'assets/test_photos/7.jpg',
  'assets/test_photos/8.jpg',
  'assets/test_photos/9.jpg',
];

String getRandomPhoto() => _testImages[Random().nextInt(_testImages.length)];

