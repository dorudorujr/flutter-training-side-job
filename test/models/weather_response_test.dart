import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/models/weather_response.dart';

void main() {
  group('WeatherResponse', () {
    test('toJson が正しいMapを返す', () {
      // Arrange
      const weatherResponse = WeatherResponse(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );

      // Act
      final json = weatherResponse.toJson();

      // Assert
      expect(json, {
        'weather_condition': 'sunny',
        'min_temperature': 10,
        'max_temperature': 20,
      });
    });

    test('toJson の結果を jsonEncode できる', () {
      // Arrange
      const weatherResponse = WeatherResponse(
        weatherCondition: 'cloudy',
        minTemperature: 5,
        maxTemperature: 15,
      );

      // Act
      final jsonString = jsonEncode(weatherResponse.toJson());

      // Assert
      expect(
        jsonString,
        '{"weather_condition":"cloudy",'
        '"min_temperature":5,"max_temperature":15}',
      );
    });

    test('fromJson が正しいWeatherResponseを返す', () {
      // Arrange
      final json = {
        'weather_condition': 'rainy',
        'min_temperature': 8,
        'max_temperature': 12,
      };

      // Act
      final weatherResponse = WeatherResponse.fromJson(json);

      // Assert
      expect(weatherResponse.weatherCondition, 'rainy');
      expect(weatherResponse.minTemperature, 8);
      expect(weatherResponse.maxTemperature, 12);
    });

    test('JSON文字列からWeatherResponseへデコードできる', () {
      // Arrange
      const jsonString = '{"weather_condition":"sunny",'
          '"min_temperature":10,"max_temperature":25}';

      // Act
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final weatherResponse = WeatherResponse.fromJson(json);

      // Assert
      expect(weatherResponse.weatherCondition, 'sunny');
      expect(weatherResponse.minTemperature, 10);
      expect(weatherResponse.maxTemperature, 25);
    });

    test('toJson と fromJson のラウンドトリップが成功する', () {
      // Arrange
      const original = WeatherResponse(
        weatherCondition: 'cloudy',
        minTemperature: -5,
        maxTemperature: 5,
      );

      // Act
      final json = original.toJson();
      final decoded = WeatherResponse.fromJson(json);

      // Assert
      expect(decoded.weatherCondition, original.weatherCondition);
      expect(decoded.minTemperature, original.minTemperature);
      expect(decoded.maxTemperature, original.maxTemperature);
    });
  });
}
