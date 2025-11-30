import 'package:flutter_training/presentation/ui_state/weather_page_ui_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_ui_state_repository.g.dart';

/// 天気ページのUI状態を管理するリポジトリ
@Riverpod(keepAlive: true)
class WeatherUiStateRepository extends _$WeatherUiStateRepository {
  @override
  WeatherPageUiState build() {
    return WeatherPageUiState.initial();
  }

  /// 天気情報を更新する
  void updateWeather({
    required String weatherCondition,
    required int minTemperature,
    required int maxTemperature,
  }) {
    state = state.copyWith(
      weatherCondition: weatherCondition,
      minTemperature: minTemperature,
      maxTemperature: maxTemperature,
      isLoading: false,
      errorMessage: null,
    );
  }

  /// ローディング状態を設定する
  void setLoading({required bool isLoading}) {
    state = state.copyWith(
      isLoading: isLoading,
      errorMessage: null,
    );
  }

  /// エラーを設定する
  void setError(String errorMessage) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: errorMessage,
    );
  }

  /// エラーをクリアする
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
