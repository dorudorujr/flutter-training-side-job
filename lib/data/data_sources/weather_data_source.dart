import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_data_source.g.dart';

/// 天気情報を取得するデータソース
class WeatherDataSource {
  WeatherDataSource(this._yumemiWeather);

  final YumemiWeather _yumemiWeather;

  /// 天気情報を取得する
  ///
  /// [requestJson] リクエストJSON文字列
  /// 戻り値: レスポンスJSON文字列
  /// throws: [YumemiWeatherError]
  String fetchWeather(String requestJson) {
    return _yumemiWeather.fetchWeather(requestJson);
  }

  /// 同期的に天気情報を取得する
  ///
  /// [requestJson] リクエストJSON文字列
  /// 戻り値: レスポンスJSON文字列
  /// throws: [YumemiWeatherError]
  String syncFetchWeather(String requestJson) {
    return _yumemiWeather.syncFetchWeather(requestJson);
  }
}

/// YumemiWeatherインスタンスを提供するProvider
@riverpod
YumemiWeather yumemiWeather(Ref ref) {
  return YumemiWeather();
}

@riverpod
WeatherDataSource weatherDataSource(Ref ref) {
  final yumemiWeather = ref.watch(yumemiWeatherProvider);
  return WeatherDataSource(yumemiWeather);
}
