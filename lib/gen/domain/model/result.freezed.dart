// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../../../domain/model/result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Result<S, F extends Exception> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data) success,
    required TResult Function(F error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(F error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(F error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<S, F> value) success,
    required TResult Function(_Failure<S, F> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<S, F> value)? success,
    TResult Function(_Failure<S, F> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<S, F> value)? success,
    TResult Function(_Failure<S, F> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<S, F extends Exception, $Res> {
  factory $ResultCopyWith(
          Result<S, F> value, $Res Function(Result<S, F>) then) =
      _$ResultCopyWithImpl<S, F, $Res>;
}

/// @nodoc
class _$ResultCopyWithImpl<S, F extends Exception, $Res>
    implements $ResultCopyWith<S, F, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  final Result<S, F> _value;
  // ignore: unused_field
  final $Res Function(Result<S, F>) _then;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<S, F extends Exception, $Res> {
  factory _$$_SuccessCopyWith(
          _$_Success<S, F> value, $Res Function(_$_Success<S, F>) then) =
      __$$_SuccessCopyWithImpl<S, F, $Res>;
  $Res call({S data});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<S, F extends Exception, $Res>
    extends _$ResultCopyWithImpl<S, F, $Res>
    implements _$$_SuccessCopyWith<S, F, $Res> {
  __$$_SuccessCopyWithImpl(
      _$_Success<S, F> _value, $Res Function(_$_Success<S, F>) _then)
      : super(_value, (v) => _then(v as _$_Success<S, F>));

  @override
  _$_Success<S, F> get _value => super._value as _$_Success<S, F>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_Success<S, F>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as S,
    ));
  }
}

/// @nodoc

class _$_Success<S, F extends Exception> extends _Success<S, F> {
  const _$_Success(this.data) : super._();

  @override
  final S data;

  @override
  String toString() {
    return 'Result<$S, $F>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success<S, F> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_SuccessCopyWith<S, F, _$_Success<S, F>> get copyWith =>
      __$$_SuccessCopyWithImpl<S, F, _$_Success<S, F>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data) success,
    required TResult Function(F error) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(F error)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(F error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<S, F> value) success,
    required TResult Function(_Failure<S, F> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<S, F> value)? success,
    TResult Function(_Failure<S, F> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<S, F> value)? success,
    TResult Function(_Failure<S, F> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<S, F extends Exception> extends Result<S, F> {
  const factory _Success(final S data) = _$_Success<S, F>;
  const _Success._() : super._();

  S get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<S, F, _$_Success<S, F>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FailureCopyWith<S, F extends Exception, $Res> {
  factory _$$_FailureCopyWith(
          _$_Failure<S, F> value, $Res Function(_$_Failure<S, F>) then) =
      __$$_FailureCopyWithImpl<S, F, $Res>;
  $Res call({F error});
}

/// @nodoc
class __$$_FailureCopyWithImpl<S, F extends Exception, $Res>
    extends _$ResultCopyWithImpl<S, F, $Res>
    implements _$$_FailureCopyWith<S, F, $Res> {
  __$$_FailureCopyWithImpl(
      _$_Failure<S, F> _value, $Res Function(_$_Failure<S, F>) _then)
      : super(_value, (v) => _then(v as _$_Failure<S, F>));

  @override
  _$_Failure<S, F> get _value => super._value as _$_Failure<S, F>;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$_Failure<S, F>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as F,
    ));
  }
}

/// @nodoc

class _$_Failure<S, F extends Exception> extends _Failure<S, F> {
  const _$_Failure(this.error) : super._();

  @override
  final F error;

  @override
  String toString() {
    return 'Result<$S, $F>.failure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Failure<S, F> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$_FailureCopyWith<S, F, _$_Failure<S, F>> get copyWith =>
      __$$_FailureCopyWithImpl<S, F, _$_Failure<S, F>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data) success,
    required TResult Function(F error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(F error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(F error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<S, F> value) success,
    required TResult Function(_Failure<S, F> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<S, F> value)? success,
    TResult Function(_Failure<S, F> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<S, F> value)? success,
    TResult Function(_Failure<S, F> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure<S, F extends Exception> extends Result<S, F> {
  const factory _Failure(final F error) = _$_Failure<S, F>;
  const _Failure._() : super._();

  F get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_FailureCopyWith<S, F, _$_Failure<S, F>> get copyWith =>
      throw _privateConstructorUsedError;
}
