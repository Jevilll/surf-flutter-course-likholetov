// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../store/place_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaceListStore on PlaceListStoreBase, Store {
  late final _$getPlacesFutureAtom =
      Atom(name: 'PlaceListStoreBase.getPlacesFuture', context: context);

  @override
  ObservableFuture<Result<List<Place>, Exception>>? get getPlacesFuture {
    _$getPlacesFutureAtom.reportRead();
    return super.getPlacesFuture;
  }

  @override
  set getPlacesFuture(ObservableFuture<Result<List<Place>, Exception>>? value) {
    _$getPlacesFutureAtom.reportWrite(value, super.getPlacesFuture, () {
      super.getPlacesFuture = value;
    });
  }

  late final _$PlaceListStoreBaseActionController =
      ActionController(name: 'PlaceListStoreBase', context: context);

  @override
  void getPlaces() {
    final _$actionInfo = _$PlaceListStoreBaseActionController.startAction(
        name: 'PlaceListStoreBase.getPlaces');
    try {
      return super.getPlaces();
    } finally {
      _$PlaceListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getPlacesFuture: ${getPlacesFuture}
    ''';
  }
}
