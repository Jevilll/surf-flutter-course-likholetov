// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../../../presentation/model/ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UiState<R> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(R result) result,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(R result)? result,
    TResult Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(R result)? result,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Result<R> value) result,
    required TResult Function(_Loading<R> value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Result<R> value)? result,
    TResult Function(_Loading<R> value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Result<R> value)? result,
    TResult Function(_Loading<R> value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiStateCopyWith<R, $Res> {
  factory $UiStateCopyWith(UiState<R> value, $Res Function(UiState<R>) then) =
      _$UiStateCopyWithImpl<R, $Res>;
}

/// @nodoc
class _$UiStateCopyWithImpl<R, $Res> implements $UiStateCopyWith<R, $Res> {
  _$UiStateCopyWithImpl(this._value, this._then);

  final UiState<R> _value;
  // ignore: unused_field
  final $Res Function(UiState<R>) _then;
}

/// @nodoc
abstract class _$$_ResultCopyWith<R, $Res> {
  factory _$$_ResultCopyWith(
          _$_Result<R> value, $Res Function(_$_Result<R>) then) =
      __$$_ResultCopyWithImpl<R, $Res>;
  $Res call({R result});
}

/// @nodoc
class __$$_ResultCopyWithImpl<R, $Res> extends _$UiStateCopyWithImpl<R, $Res>
    implements _$$_ResultCopyWith<R, $Res> {
  __$$_ResultCopyWithImpl(
      _$_Result<R> _value, $Res Function(_$_Result<R>) _then)
      : super(_value, (v) => _then(v as _$_Result<R>));

  @override
  _$_Result<R> get _value => super._value as _$_Result<R>;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_$_Result<R>(
      result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as R,
    ));
  }
}

/// @nodoc

class _$_Result<R> implements _Result<R> {
  const _$_Result(this.result);

  @override
  final R result;

  @override
  String toString() {
    return 'UiState<$R>.result(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Result<R> &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$$_ResultCopyWith<R, _$_Result<R>> get copyWith =>
      __$$_ResultCopyWithImpl<R, _$_Result<R>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(R result) result,
    required TResult Function() loading,
  }) {
    return result(this.result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(R result)? result,
    TResult Function()? loading,
  }) {
    return result?.call(this.result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(R result)? result,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this.result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Result<R> value) result,
    required TResult Function(_Loading<R> value) loading,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Result<R> value)? result,
    TResult Function(_Loading<R> value)? loading,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Result<R> value)? result,
    TResult Function(_Loading<R> value)? loading,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }
}

abstract class _Result<R> implements UiState<R> {
  const factory _Result(final R result) = _$_Result<R>;

  R get result => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_ResultCopyWith<R, _$_Result<R>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<R, $Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading<R> value, $Res Function(_$_Loading<R>) then) =
      __$$_LoadingCopyWithImpl<R, $Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<R, $Res> extends _$UiStateCopyWithImpl<R, $Res>
    implements _$$_LoadingCopyWith<R, $Res> {
  __$$_LoadingCopyWithImpl(
      _$_Loading<R> _value, $Res Function(_$_Loading<R>) _then)
      : super(_value, (v) => _then(v as _$_Loading<R>));

  @override
  _$_Loading<R> get _value => super._value as _$_Loading<R>;
}

/// @nodoc

class _$_Loading<R> implements _Loading<R> {
  const _$_Loading();

  @override
  String toString() {
    return 'UiState<$R>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading<R>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(R result) result,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(R result)? result,
    TResult Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(R result)? result,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Result<R> value) result,
    required TResult Function(_Loading<R> value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Result<R> value)? result,
    TResult Function(_Loading<R> value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Result<R> value)? result,
    TResult Function(_Loading<R> value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<R> implements UiState<R> {
  const factory _Loading() = _$_Loading<R>;
}
