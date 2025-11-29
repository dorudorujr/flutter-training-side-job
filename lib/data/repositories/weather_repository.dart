import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_sources/weather_data_source.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:flutter_training/models/weather_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_repository.g.dart';

/// 天気情報のリポジトリ
class WeatherRepository {
  WeatherRepository(this._dataSource);

  final WeatherDataSource _dataSource;

  /// 天気情報を取得する
  ///
  /// [area] 地域名
  /// [date] 日時
  /// 戻り値: [WeatherResponse]
  /// throws: [YumemiWeatherError]
  WeatherResponse fetchWeather({
    required String area,
    required DateTime date,
  }) {
    final request = WeatherRequest(
      area: area,
      date: date.toIso8601String(),
    );
    final requestJson = jsonEncode(request.toJson());

    final responseJson = _dataSource.fetchWeather(requestJson);

    final response = WeatherResponse.fromJson(
      jsonDecode(responseJson) as Map<String, dynamic>,
    );

    return response;
  }
}

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  final dataSource = ref.watch(weatherDataSourceProvider);
  return WeatherRepository(dataSource);
}
