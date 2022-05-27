import 'package:freezed_annotation/freezed_annotation.dart';

part '../../gen/presentation/model/ui_state.freezed.dart';

/// Модель данных, хранящая текущее состояние ui.
@freezed
class UiState<R> with _$UiState<R> {

  const factory UiState.result(R result) = _Result;

  const factory UiState.loading() = _Loading;
}