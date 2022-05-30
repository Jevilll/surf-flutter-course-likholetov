import 'package:freezed_annotation/freezed_annotation.dart';

part '../../gen/domain/model/result.freezed.dart';

/// Результат сетевой операции.
@freezed
class Result<S, F extends Exception> with _$Result<S, F> {

  /// Признак успешного результата.
  bool get isSuccess => this is _Success;

  /// Признак не успешного результата.
  bool get isFailure => this is _Failure;

  const Result._();

  const factory Result.success(S data) = _Success;

  const factory Result.failure(F error) = _Failure;

  /// Выполнить функцию при условии успешного результата.
  void ifSuccess(Function(S) onSuccess) {
    if (isSuccess) {
      onSuccess.call((this as _Success).data as S);
    }
  }

  /// Преобразовать успешный результат.
  Result<S, F> mapSuccess(S Function(S) onSuccess) {
    return when(success: (success) {
      return Result.success(onSuccess.call(success));
    }, failure: (failure) {
      return Result.failure(failure);
    },);
  }

  /// Преобразовать не успешный результат.
  Result<S, F> mapFailure(F Function(F) onFailure) {
    return when(success: (success) {
      return Result.success(success);
    }, failure: (failure) {
      return Result.failure(onFailure.call(failure));
    },);
  }
}
