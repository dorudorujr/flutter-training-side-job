import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repositories/weather_ui_state_repository.dart';
import 'package:flutter_training/presentation/ui_state/weather_page_ui_state.dart';

void main() {
  group('WeatherUiStateRepository', () {
    late ProviderContainer container;
    late WeatherUiStateRepository repository;

    setUp(() {
      container = ProviderContainer();
      repository = container.read(weatherUiStateRepositoryProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は WeatherPageUiState.initial() である', () {
      // Act
      final state = container.read(weatherUiStateRepositoryProvider);

      // Assert
      expect(state, WeatherPageUiState.initial());
      expect(state.weatherCondition, isNull);
      expect(state.minTemperature, isNull);
      expect(state.maxTemperature, isNull);
      expect(state.isLoading, false);
      expect(state.errorMessage, isNull);
    });

    test('updateWeather で天気情報を更新できる', () {
      // Act
      repository.updateWeather(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.weatherCondition, 'sunny');
      expect(state.minTemperature, 10);
      expect(state.maxTemperature, 20);
      expect(state.isLoading, false);
      expect(state.errorMessage, isNull);
    });

    test('setLoading でローディング状態を設定できる', () {
      // Act
      repository.setLoading(isLoading: true);

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.isLoading, true);
      expect(state.errorMessage, isNull);
    });

    test('setLoading でローディング状態を解除できる', () {
      // Arrange
      repository.setLoading(isLoading: true);

      // Act
      repository.setLoading(isLoading: false);

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.isLoading, false);
    });

    test('setError でエラーメッセージを設定できる', () {
      // Arrange
      const errorMessage = 'エラーが発生しました';

      // Act
      repository.setError(errorMessage);

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.errorMessage, errorMessage);
      expect(state.isLoading, false);
    });

    test('clearError でエラーメッセージをクリアできる', () {
      // Arrange
      repository.setError('エラーが発生しました');

      // Act
      repository.clearError();

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.errorMessage, isNull);
    });

    test('updateWeather はエラーメッセージをクリアする', () {
      // Arrange
      repository.setError('エラーが発生しました');

      // Act
      repository.updateWeather(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.errorMessage, isNull);
    });

    test('setLoading はエラーメッセージをクリアする', () {
      // Arrange
      repository.setError('エラーが発生しました');

      // Act
      repository.setLoading(isLoading: true);

      // Assert
      final state = container.read(weatherUiStateRepositoryProvider);
      expect(state.errorMessage, isNull);
    });
  });
}
