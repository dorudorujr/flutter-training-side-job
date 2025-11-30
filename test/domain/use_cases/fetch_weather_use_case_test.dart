import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:flutter_training/data/repositories/weather_ui_state_repository.dart';
import 'package:flutter_training/domain/use_cases/fetch_weather_use_case.dart';
import 'package:flutter_training/models/weather_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'fetch_weather_use_case_test.mocks.dart';

@GenerateMocks([WeatherRepository, WeatherUiStateRepository])
void main() {
  group('FetchWeatherUseCase', () {
    late MockWeatherRepository mockWeatherRepository;
    late MockWeatherUiStateRepository mockWeatherUiStateRepository;
    late FetchWeatherUseCase fetchWeatherUseCase;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      mockWeatherUiStateRepository = MockWeatherUiStateRepository();
      fetchWeatherUseCase = FetchWeatherUseCase(
        weatherRepository: mockWeatherRepository,
        weatherUiStateRepository: mockWeatherUiStateRepository,
      );
    });

    test('execute が成功時、正しい順序でUI状態を更新する', () async {
      // Arrange
      const weatherResponse = WeatherResponse(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );

      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenReturn(weatherResponse);

      // Act
      await fetchWeatherUseCase.execute();

      // Assert - 呼び出し順序を確認
      verifyInOrder([
        // 1. ローディング開始
        mockWeatherUiStateRepository.setLoading(isLoading: true),
        // 2. 天気情報取得
        mockWeatherRepository.fetchWeather(
          area: 'tokyo',
          date: anyNamed('date'),
        ),
        // 3. UI状態更新
        mockWeatherUiStateRepository.updateWeather(
          weatherCondition: 'sunny',
          minTemperature: 10,
          maxTemperature: 20,
        ),
      ]);
    });

    test('execute が invalidParameter エラー時、エラーメッセージを設定する', () async {
      // Arrange
      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenThrow(YumemiWeatherError.invalidParameter);

      // Act
      await fetchWeatherUseCase.execute();

      // Assert
      verifyInOrder([
        // 1. ローディング開始
        mockWeatherUiStateRepository.setLoading(isLoading: true),
        // 2. 天気情報取得を試みる
        mockWeatherRepository.fetchWeather(
          area: 'tokyo',
          date: anyNamed('date'),
        ),
        // 3. エラーメッセージを設定
        mockWeatherUiStateRepository.setError('無効なパラメータが指定されました。'),
      ]);

      // updateWeather が呼ばれないことを確認
      verifyNever(
        mockWeatherUiStateRepository.updateWeather(
          weatherCondition: anyNamed('weatherCondition'),
          minTemperature: anyNamed('minTemperature'),
          maxTemperature: anyNamed('maxTemperature'),
        ),
      );
    });

    test('execute が unknown エラー時、エラーメッセージを設定する', () async {
      // Arrange
      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenThrow(YumemiWeatherError.unknown);

      // Act
      await fetchWeatherUseCase.execute();

      // Assert
      verifyInOrder([
        // 1. ローディング開始
        mockWeatherUiStateRepository.setLoading(isLoading: true),
        // 2. 天気情報取得を試みる
        mockWeatherRepository.fetchWeather(
          area: 'tokyo',
          date: anyNamed('date'),
        ),
        // 3. エラーメッセージを設定
        mockWeatherUiStateRepository.setError(
          '予期しないエラーが発生しました。\nもう一度お試しください。',
        ),
      ]);

      // updateWeather が呼ばれないことを確認
      verifyNever(
        mockWeatherUiStateRepository.updateWeather(
          weatherCondition: anyNamed('weatherCondition'),
          minTemperature: anyNamed('minTemperature'),
          maxTemperature: anyNamed('maxTemperature'),
        ),
      );
    });

    test('execute が複数回呼ばれても正しく動作する', () async {
      // Arrange
      const weatherResponse1 = WeatherResponse(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );
      const weatherResponse2 = WeatherResponse(
        weatherCondition: 'cloudy',
        minTemperature: 5,
        maxTemperature: 15,
      );

      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenAnswer((_) => weatherResponse1);

      // Act - 1回目
      await fetchWeatherUseCase.execute();

      // 2回目のレスポンスを設定
      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenAnswer((_) => weatherResponse2);

      // Act - 2回目
      await fetchWeatherUseCase.execute();

      // Assert
      verify(mockWeatherUiStateRepository.setLoading(isLoading: true))
          .called(2);
      verify(
        mockWeatherRepository.fetchWeather(
          area: 'tokyo',
          date: anyNamed('date'),
        ),
      ).called(2);
      verify(
        mockWeatherUiStateRepository.updateWeather(
          weatherCondition: 'sunny',
          minTemperature: 10,
          maxTemperature: 20,
        ),
      ).called(1);
      verify(
        mockWeatherUiStateRepository.updateWeather(
          weatherCondition: 'cloudy',
          minTemperature: 5,
          maxTemperature: 15,
        ),
      ).called(1);
    });

    test('execute が成功→失敗→成功の順で呼ばれても正しく動作する', () async {
      // Arrange
      const weatherResponse = WeatherResponse(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );

      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenReturn(weatherResponse);

      // Act - 1回目（成功）
      await fetchWeatherUseCase.execute();

      // 2回目（失敗）
      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenThrow(YumemiWeatherError.unknown);

      await fetchWeatherUseCase.execute();

      // 3回目（成功）
      when(
        mockWeatherRepository.fetchWeather(
          area: anyNamed('area'),
          date: anyNamed('date'),
        ),
      ).thenReturn(weatherResponse);

      await fetchWeatherUseCase.execute();

      // Assert
      verify(mockWeatherUiStateRepository.setLoading(isLoading: true))
          .called(3);
      verify(
        mockWeatherUiStateRepository.updateWeather(
          weatherCondition: 'sunny',
          minTemperature: 10,
          maxTemperature: 20,
        ),
      ).called(2);
      verify(
        mockWeatherUiStateRepository.setError(
          '予期しないエラーが発生しました。\nもう一度お試しください。',
        ),
      ).called(1);
    });
  });
}
