
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/position.dart';

final List<Place> mocks = [
  Place(
    id: 1,
    name: 'лучший отель',
    position: Position(55.75222, 37.61556),
    description:
        '''
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi at sem id purus sagittis venenatis eget sed metus. Duis fermentum urna sem. Pellentesque auctor lacus ipsum, id ultricies ligula viverra eget. Maecenas lobortis fringilla lectus in sodales. Sed non scelerisque justo. Vestibulum bibendum accumsan felis, ut laoreet odio accumsan at. Maecenas facilisis magna vitae rhoncus mollis. Integer condimentum nulla est, et bibendum mi iaculis vitae. Nam imperdiet id massa in congue. Etiam viverra, nulla et luctus porta, nunc tortor sollicitudin libero, a sagittis erat sem nec quam. Mauris finibus hendrerit facilisis. Mauris id nisl a eros molestie egestas non ut elit. Proin blandit id est et ornare.
        
       Fusce malesuada dolor efficitur tincidunt pretium. Praesent ultrices ullamcorper metus pellentesque rutrum. Praesent vitae tempor mi, eget lacinia neque. Aliquam blandit mauris non erat tempor, eu suscipit neque semper. Sed ornare felis eget erat consequat ornare. Maecenas quis arcu dapibus, condimentum risus sed, dapibus ipsum. Suspendisse commodo egestas lorem at convallis. Suspendisse facilisis nisi ac eros bibendum hendrerit. Nulla malesuada eu mauris auctor elementum. Sed sit amet sem aliquet, efficitur urna ac, fermentum felis. Vivamus nec risus nec elit fringilla vulputate.
       
       Donec ex tortor, dapibus in convallis sit amet, tristique venenatis sapien. Pellentesque iaculis diam ligula, non rutrum neque elementum consectetur. Nunc ut interdum ligula, quis tempus nulla. Vestibulum varius ullamcorper ante, at rhoncus augue pretium vel. Pellentesque id risus metus. Phasellus ullamcorper vehicula magna, eu placerat sem venenatis lacinia. In eget libero commodo, aliquet ligula a, porta nisi. Suspendisse non vulputate ipsum. Aliquam convallis nunc id auctor sodales. Praesent vulputate dapibus ligula, eu lacinia odio mattis eu. Curabitur eu rhoncus eros. Nunc non elit eros. Maecenas molestie elit eros, aliquam tincidunt lorem egestas vel.''',
    type: Type.hotel,
    urls: [
      'https://dynl.mktgcdn.com/p/AysCZU1TCaImKSFxQhzPq9HiOWjMRz3ywq4h1pYqtII/600x450.jpg',
      'https://www.hotel-library.com/userfls/ufiles/Библио%20094_done-маленькая.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-s/1b/54/d3/bb/caption.jpg',
      'https://hotel-spb.ru/assets/components/phpthumbof/cache/room-business_002.788c4c20502cae038e66e118c369e7b7.jpg',
      'https://www.president-hotel.ru/upload/iblock/a3e/a3e904fead2f3c8178bdff7e284b3aaf.jpg',
    ],
    timeToVisit: 'Запланировано на 12 окт. 2020',
    workingHours: 'закрыто до 9:00',
  ),
  Place(
    id: 1,
    name: 'Средний ресторан',
    position: Position(55.75222, 37.61556),
    description: 'Описание',
    type: Type.restaurant,
    urls: [
      'https://media.admagazine.ru/photos/61407d5e9ecf4e1934c46f10/16:9/w_2560%2Cc_limit/IMG_7838.jpg',
    ],
  ),
  Place(
    id: 1,
    name: 'Самое особое',
    position: Position(55.75222, 37.61556),
    description: 'Описание',
    type: Type.other,
    urls: [
      'https://gcdn.tomesto.ru/img/place/000/026/236/restoran-osoboe-mesto-v-trehprudnom-pereulke_9940e_full-174438.jpg',
    ],
  ),
  Place(
    id: 1,
    name: 'Большой парк',
    position: Position(55.75222, 37.61556),
    description: 'Описание',
    type: Type.park,
    urls: [
      'https://static5.depositphotos.com/1004999/458/i/600/depositphotos_4582193-stock-photo-beautiful-spring-park.jpg',
    ],
  ),
  Place(
    id: 1,
    name: 'Старый музей',
    position: Position(55.75222, 37.61556),
    description: 'Описание',
    type: Type.museum,
    urls: ['https://cdn.culture.ru/c/75570.jpg'],
  ),
  Place(
    id: 1,
    name: 'Небольшое кафе',
    position: Position(55.75222, 37.61556),
    description: 'Описание',
    type: Type.cafe,
    urls: [
      'https://gcdn.tomesto.ru/img/place/000/023/404/restoran-corner-cafe-korner-kafe-na-kompozitorskoy-ulitse_bc545_full-317836.jpg',
    ],
  ),
];

final List<Place> mocksToVisit = List.from(mocks);
final List<Place> mocksVisited = List.from(mocks);