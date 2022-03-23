import 'package:places/domain/sight.dart';

final List<Sight> mocks = [bronzeHorseman, timesSquare, lakeBaikal];

final bronzeHorseman = Sight(
  'Bronze Horseman',
  lat: 59.9363823,
  long: 30.3022308,
  details: 'Памятник Петру I на Сенатской площади в Санкт-Петербурге',
  type: Type.monument,
);

final timesSquare = Sight(
  'Times Square',
  lat: 40.75773,
  long: -73.985708,
  details: 'Площадь в центральной части Манхэттена',
  type: Type.square,
);

final lakeBaikal = Sight(
  'Озеро Байкал',
  lat: 51.90503,
  long: 126.62002,
  details: 'Самое глубокое озеро на планете',
  type: Type.lake,
);
