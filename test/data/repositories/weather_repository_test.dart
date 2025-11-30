import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/data_sources/weather_data_source.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([WeatherDataSource])
void main() {
  group('WeatherRepository', () {
    late MockWeatherDataSource mockDataSource;
    late WeatherRepository weatherRepository;

    setUp(() {
      mockDataSource = MockWeatherDataSource();
      weatherRepository = WeatherRepository(mockDataSource);
    });

    test('fetchWeather が成功時、WeatherResponse を返す', () {
      // Arrange
      final date = DateTime(2024);
      const area = 'tokyo';
      const responseJson = '{"weather_condition":"sunny",'
          '"min_temperature":10,"max_temperature":20}';

      when(mockDataSource.fetchWeather(any)).thenReturn(responseJson);

      // Act
      final result = weatherRepository.fetchWeather(
        area: area,
        date: date,
      );

      // Assert
      expect(result.weatherCondition, 'sunny');
      expect(result.minTemperature, 10);
      expect(result.maxTemperature, 20);

      // リクエストJSONが正しく作成されていることを確認
      final captured =
          verify(mockDataSource.fetchWeather(captureAny)).captured;
      expect(captured.length, 1);
      expect(captured[0], contains('"area":"tokyo"'));
      expect(captured[0], contains('"date":"2024-01-01T00:00:00.000"'));
    });

    test('fetchWeather が invalidParameter エラーをスローする', () {
      // Arrange
      final date = DateTime(2024);
      const area = 'invalid_area';

      when(mockDataSource.fetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act & Assert
      expect(
        () => weatherRepository.fetchWeather(
          area: area,
          date: date,
        ),
        throwsA(YumemiWeatherError.invalidParameter),
      );
    });

    test('fetchWeather が unknown エラーをスローする', () {
      // Arrange
      final date = DateTime(2024);
      const area = 'tokyo';

      when(mockDataSource.fetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      // Act & Assert
      expect(
        () => weatherRepository.fetchWeather(
          area: area,
          date: date,
        ),
        throwsA(YumemiWeatherError.unknown),
      );
    });

    test('fetchWeather がJSON decode エラーをスローする', () {
      // Arrange
      final date = DateTime(2024);
      const area = 'tokyo';
      const invalidJson = 'invalid json';

      when(mockDataSource.fetchWeather(any)).thenReturn(invalidJson);

      // Act & Assert
      expect(
        () => weatherRepository.fetchWeather(
          area: area,
          date: date,
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
