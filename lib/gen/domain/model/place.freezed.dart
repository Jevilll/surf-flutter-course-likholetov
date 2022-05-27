// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../../../domain/model/place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Place {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Position get position => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Type get type => throw _privateConstructorUsedError;
  List<String> get urls => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  set distance(double? value) => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  set isFavorite(bool value) => throw _privateConstructorUsedError;
  String get timeToVisit => throw _privateConstructorUsedError;
  set timeToVisit(String value) => throw _privateConstructorUsedError;
  String get workingHours => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceCopyWith<Place> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCopyWith<$Res> {
  factory $PlaceCopyWith(Place value, $Res Function(Place) then) =
      _$PlaceCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      Position position,
      String description,
      Type type,
      List<String> urls,
      double? distance,
      bool isFavorite,
      String timeToVisit,
      String workingHours});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$PlaceCopyWithImpl<$Res> implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._value, this._then);

  final Place _value;
  // ignore: unused_field
  final $Res Function(Place) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? position = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? urls = freezed,
    Object? distance = freezed,
    Object? isFavorite = freezed,
    Object? timeToVisit = freezed,
    Object? workingHours = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Type,
      urls: urls == freezed
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      timeToVisit: timeToVisit == freezed
          ? _value.timeToVisit
          : timeToVisit // ignore: cast_nullable_to_non_nullable
              as String,
      workingHours: workingHours == freezed
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $PositionCopyWith<$Res> get position {
    return $PositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value));
    });
  }
}

/// @nodoc
abstract class _$$_PlaceCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$$_PlaceCopyWith(_$_Place value, $Res Function(_$_Place) then) =
      __$$_PlaceCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      Position position,
      String description,
      Type type,
      List<String> urls,
      double? distance,
      bool isFavorite,
      String timeToVisit,
      String workingHours});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$_PlaceCopyWithImpl<$Res> extends _$PlaceCopyWithImpl<$Res>
    implements _$$_PlaceCopyWith<$Res> {
  __$$_PlaceCopyWithImpl(_$_Place _value, $Res Function(_$_Place) _then)
      : super(_value, (v) => _then(v as _$_Place));

  @override
  _$_Place get _value => super._value as _$_Place;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? position = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? urls = freezed,
    Object? distance = freezed,
    Object? isFavorite = freezed,
    Object? timeToVisit = freezed,
    Object? workingHours = freezed,
  }) {
    return _then(_$_Place(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Type,
      urls: urls == freezed
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      timeToVisit: timeToVisit == freezed
          ? _value.timeToVisit
          : timeToVisit // ignore: cast_nullable_to_non_nullable
              as String,
      workingHours: workingHours == freezed
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Place implements _Place {
  _$_Place(
      {required this.id,
      required this.name,
      required this.position,
      required this.description,
      required this.type,
      required this.urls,
      this.distance,
      this.isFavorite = false,
      this.timeToVisit = '',
      this.workingHours = ''});

  @override
  final int id;
  @override
  final String name;
  @override
  final Position position;
  @override
  final String description;
  @override
  final Type type;
  @override
  final List<String> urls;
  @override
  double? distance;
  @override
  @JsonKey()
  bool isFavorite;
  @override
  @JsonKey()
  String timeToVisit;
  @override
  @JsonKey()
  final String workingHours;

  @override
  String toString() {
    return 'Place(id: $id, name: $name, position: $position, description: $description, type: $type, urls: $urls, distance: $distance, isFavorite: $isFavorite, timeToVisit: $timeToVisit, workingHours: $workingHours)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_PlaceCopyWith<_$_Place> get copyWith =>
      __$$_PlaceCopyWithImpl<_$_Place>(this, _$identity);
}

abstract class _Place implements Place {
  factory _Place(
      {required final int id,
      required final String name,
      required final Position position,
      required final String description,
      required final Type type,
      required final List<String> urls,
      double? distance,
      bool isFavorite,
      String timeToVisit,
      final String workingHours}) = _$_Place;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  Position get position => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  Type get type => throw _privateConstructorUsedError;
  @override
  List<String> get urls => throw _privateConstructorUsedError;
  @override
  double? get distance => throw _privateConstructorUsedError;
  @override
  bool get isFavorite => throw _privateConstructorUsedError;
  @override
  String get timeToVisit => throw _privateConstructorUsedError;
  @override
  String get workingHours => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PlaceCopyWith<_$_Place> get copyWith =>
      throw _privateConstructorUsedError;
}
