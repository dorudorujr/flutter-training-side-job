import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/data_sources/weather_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_data_source_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  group('WeatherDataSource', () {
    late MockYumemiWeather mockYumemiWeather;
    late WeatherDataSource weatherDataSource;

    setUp(() {
      mockYumemiWeather = MockYumemiWeather();
      weatherDataSource = WeatherDataSource(mockYumemiWeather);
    });

    test('fetchWeather が成功時、YumemiWeather から返されたJSON文字列を返す', () {
      // Arrange
      const requestJson = '{"area":"tokyo","date":"2024-01-01T00:00:00.000"}';
      const expectedResponse =
          '{"weatherCondition":"sunny","minTemperature":10,"maxTemperature":20}';
      when(mockYumemiWeather.fetchWeather(requestJson))
          .thenReturn(expectedResponse);

      // Act
      final result = weatherDataSource.fetchWeather(requestJson);

      // Assert
      expect(result, expectedResponse);
      verify(mockYumemiWeather.fetchWeather(requestJson)).called(1);
    });

    test('fetchWeather が失敗時、YumemiWeatherError をスローする', () {
      // Arrange
      const requestJson = 'invalid json';
      when(mockYumemiWeather.fetchWeather(requestJson))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act & Assert
      expect(
        () => weatherDataSource.fetchWeather(requestJson),
        throwsA(isA<YumemiWeatherError>()),
      );
      verify(mockYumemiWeather.fetchWeather(requestJson)).called(1);
    });

    test('fetchWeather が unknown エラーをスローする', () {
      // Arrange
      const requestJson = '{"area":"tokyo","date":"2024-01-01T00:00:00.000"}';
      when(mockYumemiWeather.fetchWeather(requestJson))
          .thenThrow(YumemiWeatherError.unknown);

      // Act & Assert
      expect(
        () => weatherDataSource.fetchWeather(requestJson),
        throwsA(YumemiWeatherError.unknown),
      );
      verify(mockYumemiWeather.fetchWeather(requestJson)).called(1);
    });
  });
}
