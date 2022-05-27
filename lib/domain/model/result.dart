import 'package:freezed_annotation/freezed_annotation.dart';

part '../../gen/domain/model/result.freezed.dart';

/// Результат сетевой операции.
@freezed
class Result<S,F extends Exception> with _$Result<S,F>{
  const factory Result.success(S data) = _Success;
  const factory Result.failure(F error) = _Failure;
}