import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:flutter_training/data/repositories/weather_ui_state_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'fetch_weather_use_case.g.dart';

/// 天気情報を取得するユースケース
class FetchWeatherUseCase {
  FetchWeatherUseCase({
    required this.weatherRepository,
    required this.weatherUiStateRepository,
  });

  final WeatherRepository weatherRepository;
  final WeatherUiStateRepository weatherUiStateRepository;

  /// 天気情報を取得する
  Future<void> execute() async {
    // ローディング開始
    weatherUiStateRepository.setLoading(isLoading: true);

    try {
      final response = await weatherRepository.syncFetchWeather(
        area: 'tokyo',
        date: DateTime.now(),
      );

      // 成功時、UI状態を更新
      weatherUiStateRepository.updateWeather(
        weatherCondition: response.weatherCondition,
        minTemperature: response.minTemperature,
        maxTemperature: response.maxTemperature,
      );
    } on YumemiWeatherError catch (e) {
      // エラー時
      final message = switch (e) {
        YumemiWeatherError.invalidParameter =>
          '無効なパラメータが指定されました。',
        YumemiWeatherError.unknown =>
          '予期しないエラーが発生しました。\nもう一度お試しください。',
      };

      weatherUiStateRepository.setError(message);
    }
  }
}

@riverpod
FetchWeatherUseCase fetchWeatherUseCase(Ref ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final weatherUiStateRepository =
      ref.watch(weatherUiStateRepositoryProvider.notifier);

  return FetchWeatherUseCase(
    weatherRepository: weatherRepository,
    weatherUiStateRepository: weatherUiStateRepository,
  );
}
