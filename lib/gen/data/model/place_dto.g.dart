// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/model/place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaceDto _$$_PlaceDtoFromJson(Map<String, dynamic> json) => _$_PlaceDto(
      id: json['id'] as int,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      placeType: json['placeType'] as String,
      description: json['description'] as String,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_PlaceDtoToJson(_$_PlaceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'urls': instance.urls,
      'placeType': instance.placeType,
      'description': instance.description,
      'distance': instance.distance,
    };
