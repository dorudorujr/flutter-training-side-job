import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/models/weather_request.dart';

void main() {
  group('WeatherRequest', () {
    test('toJson が正しいMapを返す', () {
      // Arrange
      const weatherRequest = WeatherRequest(
        area: 'tokyo',
        date: '2024-01-01T00:00:00.000',
      );

      // Act
      final json = weatherRequest.toJson();

      // Assert
      expect(json, {
        'area': 'tokyo',
        'date': '2024-01-01T00:00:00.000',
      });
    });

    test('toJson の結果を jsonEncode できる', () {
      // Arrange
      const weatherRequest = WeatherRequest(
        area: 'tokyo',
        date: '2024-01-01T00:00:00.000',
      );

      // Act
      final jsonString = jsonEncode(weatherRequest.toJson());

      // Assert
      expect(
        jsonString,
        '{"area":"tokyo","date":"2024-01-01T00:00:00.000"}',
      );
    });

    test('fromJson が正しいWeatherRequestを返す', () {
      // Arrange
      final json = {
        'area': 'osaka',
        'date': '2024-12-31T23:59:59.999',
      };

      // Act
      final weatherRequest = WeatherRequest.fromJson(json);

      // Assert
      expect(weatherRequest.area, 'osaka');
      expect(weatherRequest.date, '2024-12-31T23:59:59.999');
    });

    test('JSON文字列からWeatherRequestへデコードできる', () {
      // Arrange
      const jsonString = '{"area":"kyoto","date":"2024-06-15T12:00:00.000"}';

      // Act
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final weatherRequest = WeatherRequest.fromJson(json);

      // Assert
      expect(weatherRequest.area, 'kyoto');
      expect(weatherRequest.date, '2024-06-15T12:00:00.000');
    });

    test('toJson と fromJson のラウンドトリップが成功する', () {
      // Arrange
      const original = WeatherRequest(
        area: 'sapporo',
        date: '2024-03-20T09:30:00.000',
      );

      // Act
      final json = original.toJson();
      final decoded = WeatherRequest.fromJson(json);

      // Assert
      expect(decoded.area, original.area);
      expect(decoded.date, original.date);
    });
  });
}
