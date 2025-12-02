import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_sources/weather_data_source.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:flutter_training/models/weather_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_repository.g.dart';

/// Isolateで実行するための引数クラス
class _SyncFetchWeatherParams {
  const _SyncFetchWeatherParams({
    required this.dataSource,
    required this.area,
    required this.date,
  });

  final WeatherDataSource dataSource;
  final String area;
  final DateTime date;
}

/// Isolateで実行するためのトップレベル関数
/// リクエストのパース → API呼び出し → レスポンスのパースまで全て実行
WeatherResponse _syncFetchWeatherInIsolate(_SyncFetchWeatherParams params) {
  // リクエストのパース処理
  final request = WeatherRequest(
    area: params.area,
    date: params.date.toIso8601String(),
  );
  final requestJson = jsonEncode(request.toJson());

  // API呼び出し
  final responseJson = params.dataSource.syncFetchWeather(requestJson);

  // レスポンスのパース処理
  final response = WeatherResponse.fromJson(
    jsonDecode(responseJson) as Map<String, dynamic>,
  );

  return response;
}

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

  /// 同期的に天気情報を取得する（Isolateで実行）
  ///
  /// リクエストのパース、API呼び出し、レスポンスのパース全てをIsolateで実行
  ///
  /// [area] 地域名
  /// [date] 日時
  /// 戻り値: [WeatherResponse]
  /// throws: [YumemiWeatherError]
  Future<WeatherResponse> syncFetchWeather({
    required String area,
    required DateTime date,
  }) async {
    return compute(
      _syncFetchWeatherInIsolate,
      _SyncFetchWeatherParams(
        dataSource: _dataSource,
        area: area,
        date: date,
      ),
    );
  }
}

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  final dataSource = ref.watch(weatherDataSourceProvider);
  return WeatherRepository(dataSource);
}
