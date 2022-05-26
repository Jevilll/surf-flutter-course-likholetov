import 'package:freezed_annotation/freezed_annotation.dart';

part '../../gen/domain/model/position.freezed.dart';

/// Модель данных координат.
@freezed
class Position with _$Position {

  const factory Position(
    double lat,
    double lng,
  ) = _Position;
}
