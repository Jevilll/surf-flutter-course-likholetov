import 'package:places/data/api/rest_api.dart';
import 'package:places/data/api/rest_deserializer.dart';
import 'package:places/data/api/rest_impl.dart';
import 'package:places/data/mapper/place_mapper.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/result.dart';
import 'package:places/domain/repository/places_repository.dart';

/// Реализация репозитория сетевых взаимодействий с местами.
class PlacesRepositoryImpl extends PlacesRepository {
  late final RestApi api;
  late final PlaceMapper placeMapper;

  PlacesRepositoryImpl() {
    api = RestImpl();
    placeMapper = PlaceMapper();
  }

  @override
  Future<Result<Place, Exception>> getPlace({required int id}) async {
    try {
      final response = await api.get('/place/$id');

      final placeDto = RestDeserializer.map<PlaceDto, PlaceDto>(response, PlaceDto.fromJson);
      final place = placeMapper.fromDto(placeDto);

      return Result.success(place);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<Place>, Exception>> getPlaces() async {
    try {
      final response = await api.get('/place');

      final placesDto = RestDeserializer.map<List<PlaceDto>, PlaceDto>(response, PlaceDto.fromJson);
      final places = placesDto.map<Place>(placeMapper.fromDto).toList();

      return Result.success(places);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<Place>, Exception>> getFilteredPlaces({required PlaceFilterRequest filterRequest}) async {
    try {
      final response = await api.post(
        '/filtered_places',
        data: filterRequest.toJson(),
      );

      final placesDto = RestDeserializer.map<List<PlaceDto>, PlaceDto>(response, PlaceDto.fromJson);
      final places = placesDto.map<Place>(placeMapper.fromDto).toList();

      return Result.success(places);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<Place, Exception>> addNewPlace(Place newPlace) async {
    try {
      final newPlaceDto = placeMapper.toDto(newPlace);
      final response = await api.post('/place', params: newPlaceDto.toJson());

      final placeDto = RestDeserializer.map<PlaceDto, PlaceDto>(response, PlaceDto.fromJson);
      final place = placeMapper.fromDto(placeDto);

      return Result.success(place);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
