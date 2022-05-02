import 'dart:math';

import 'package:places/domain/position.dart';
import 'package:places/domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    'лучший отель',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.hotel,
    images:
    ['https://dynl.mktgcdn.com/p/AysCZU1TCaImKSFxQhzPq9HiOWjMRz3ywq4h1pYqtII/600x450.jpg',
    'https://www.hotel-library.com/userfls/ufiles/Библио%20094_done-маленькая.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/1b/54/d3/bb/caption.jpg',
    'https://hotel-spb.ru/assets/components/phpthumbof/cache/room-business_002.788c4c20502cae038e66e118c369e7b7.jpg',
    'https://www.president-hotel.ru/upload/iblock/a3e/a3e904fead2f3c8178bdff7e284b3aaf.jpg',],
    timeToVisit: 'Запланировано на 12 окт. 2020',
    workingHours: 'закрыто до 9:00',
  ),
  Sight(
    'Средний ресторан',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.restaurant,
    images:
    ['https://media.admagazine.ru/photos/61407d5e9ecf4e1934c46f10/16:9/w_2560%2Cc_limit/IMG_7838.jpg'],
  ),
  Sight(
    'Самое особое',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    images:
    ['https://gcdn.tomesto.ru/img/place/000/026/236/restoran-osoboe-mesto-v-trehprudnom-pereulke_9940e_full-174438.jpg'],
  ),
  Sight(
    'Большой парк',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.park,
    images:
    ['https://static5.depositphotos.com/1004999/458/i/600/depositphotos_4582193-stock-photo-beautiful-spring-park.jpg'],
  ),
  Sight(
    'Старый музей',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.museum,
    images: ['https://cdn.culture.ru/c/75570.jpg'],
  ),
  Sight(
    'Небольшое кафе',
    position: Position(55.75222, 37.61556),
    details: 'Описание',
    type: Type.cafe,
    images:
    ['https://gcdn.tomesto.ru/img/place/000/023/404/restoran-corner-cafe-korner-kafe-na-kompozitorskoy-ulitse_bc545_full-317836.jpg'],
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

