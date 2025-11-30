import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_page_ui_state.freezed.dart';

/// 天気ページのUI状態
@freezed
class WeatherPageUiState with _$WeatherPageUiState {
  const factory WeatherPageUiState({
    /// 天気の状態（sunny, cloudy, rainy）
    String? weatherCondition,

    /// 最低気温
    int? minTemperature,

    /// 最高気温
    int? maxTemperature,

    /// ローディング中かどうか
    @Default(false) bool isLoading,

    /// エラーメッセージ
    String? errorMessage,
  }) = _WeatherPageUiState;

  /// 初期状態
  factory WeatherPageUiState.initial() => const WeatherPageUiState();
}
