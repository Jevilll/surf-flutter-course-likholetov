import 'package:places/domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    'Бронзовый всадник',
    lat: 59.9363823,
    long: 30.3022308,
    shortDescription:
        'Бронзовый всадник - Памятник Петру I на Сенатской площади в Санкт-Петербурге',
    details:
        'Медный всадник в Санкт-Петербурге — самый известный памятник Петру I. Он расположен в открытом сквере на Сенатской площади и является уникальным произведением русской и мировой культуры.',
    type: Type.monument,
    image: 'https://hotel.democrat/wp-content/uploads/2015/10/mednyy-vsadnik.jpg',
  ),
  Sight(
    'Times Square',
    lat: 40.75773,
    long: -73.985708,
    shortDescription: 'Times Square - Площадь в центральной части Манхэттена',
    details:
        'Таймс-сквер является одной из самых посещаемых достопримечательностей мира, привлекающей около 50 миллионов посетителей ежегодно.',
    type: Type.square,
    image: 'https://fs.tonkosti.ru/11/q6/11q60iy3utzkc8ws4gwgocs4w.jpg',
  ),
  Sight(
    'Озеро Байкал',
    lat: 51.90503,
    long: 126.62002,
    shortDescription: 'Озеро Байкал - Самое глубокое озеро на планете',
    details:
        'Озеро тектонического происхождения в южной части Восточной Сибири, самое глубокое озеро на планете, крупнейший природный резервуар пресной воды и самое большое по площади пресноводное озеро на континенте.',
    type: Type.lake,
    image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/%D0%9C%D1%8B%D1%81_%D0%9B%D1%83%D0%B4%D0%B0%D1%80%D1%8C%2C_17_%D0%B8%D1%8E%D0%BD%D1%8F_2013_%D0%B3%D0%BE%D0%B4%D0%B0.jpg/1920px-%D0%9C%D1%8B%D1%81_%D0%9B%D1%83%D0%B4%D0%B0%D1%80%D1%8C%2C_17_%D0%B8%D1%8E%D0%BD%D1%8F_2013_%D0%B3%D0%BE%D0%B4%D0%B0.jpg',
  ),
];
