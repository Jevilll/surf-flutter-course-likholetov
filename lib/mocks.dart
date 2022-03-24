import 'package:places/domain/sight.dart';

final List<Sight> mocks = [bronzeHorseman, timesSquare, lakeBaikal];

final bronzeHorseman = Sight(
  'Бронзовый всадник - Памятник Петру I на Сенатской площади в Санкт-Петербурге',
  lat: 59.9363823,
  long: 30.3022308,
  details: '''
      Медный всадник в Санкт-Петербурге — самый известный памятник Петру I. 
      Он расположен в открытом сквере на Сенатской площади и является 
      уникальным произведением русской и мировой культуры. Медный всадник 
      окружен  известными достопримечательностями:  с запада расположены 
      здания Сената и Синода, с востока — Адмиралтейство, 
      с юга — Исаакиевский собор.''',
  type: Type.monument,
);

final timesSquare = Sight(
  'Times Square - Площадь в центральной части Манхэттена',
  lat: 40.75773,
  long: -73.985708,
  details: '''
  Таймс-сквер является одной из самых посещаемых достопримечательностей мира, 
  привлекающей около 50 миллионов посетителей ежегодно. Площадь называют 
  «перекрёстком мира», она ежедневно пропускает через себя более 300 тысяч 
  пешеходов и 115 тысяч водителей и пассажиров, на ней работает 170 тысяч 
  человек. Таймс-сквер является символом Нью-Йорка и всех Соединённых Штатов''',
  type: Type.square,
);

final lakeBaikal = Sight(
  'Озеро Байкал - Самое глубокое озеро на планете',
  lat: 51.90503,
  long: 126.62002,
  details: '''
  озеро тектонического происхождения в южной части Восточной Сибири, 
  самое глубокое озеро на планете, крупнейший природный резервуар пресной 
  воды и самое большое по площади пресноводное озеро на континенте. 
  Озеро и прибрежные территории отличаются уникальным разнообразием флоры и 
  фауны, бо́льшая часть видов животных эндемична.''',
  type: Type.lake,
);