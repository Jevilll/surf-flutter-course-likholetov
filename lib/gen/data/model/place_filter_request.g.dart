// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/model/place_filter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PlaceFilterRequestToJson(PlaceFilterRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lat', instance.lat);
  writeNotNull('lng', instance.lng);
  writeNotNull('radius', instance.radius);
  writeNotNull('typeFilter', instance.typeFilter?.toList());
  writeNotNull('nameFilter', instance.nameFilter);
  return val;
}
