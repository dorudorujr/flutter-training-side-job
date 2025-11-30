import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/presentation/providers/weather_page_ui_state_provider.dart';
import 'package:flutter_training/presentation/ui_state/weather_page_ui_state.dart';
import 'package:flutter_training/weather_screen.dart';

void main() {
  group('WeatherScreen Widget Tests', () {
    testWidgets('晴れの画像が表示されること', (tester) async {
      // Arrange
      // テスト環境の画面サイズを設定
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const testState = WeatherPageUiState(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 20,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherPageUiStateProvider.overrideWith((ref) => testState),
          ],
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );

      // Act & Assert
      final svgFinder = find.byType(SvgPicture);
      expect(svgFinder, findsOneWidget);

      final svgWidget = tester.widget<SvgPicture>(svgFinder);
      final assetName = (svgWidget.bytesLoader as SvgAssetLoader).assetName;
      expect(assetName, 'assets/images/sunny.svg');
    });

    testWidgets('曇りの画像が表示されること', (tester) async {
      // Arrange
      // テスト環境の画面サイズを設定
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const testState = WeatherPageUiState(
        weatherCondition: 'cloudy',
        minTemperature: 15,
        maxTemperature: 25,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherPageUiStateProvider.overrideWith((ref) => testState),
          ],
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );

      // Act & Assert
      final svgFinder = find.byType(SvgPicture);
      expect(svgFinder, findsOneWidget);

      final svgWidget = tester.widget<SvgPicture>(svgFinder);
      final assetName = (svgWidget.bytesLoader as SvgAssetLoader).assetName;
      expect(assetName, 'assets/images/cloudy.svg');
    });

    testWidgets('雨の画像が表示されること', (tester) async {
      // Arrange
      // テスト環境の画面サイズを設定
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const testState = WeatherPageUiState(
        weatherCondition: 'rainy',
        minTemperature: 5,
        maxTemperature: 15,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherPageUiStateProvider.overrideWith((ref) => testState),
          ],
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );

      // Act & Assert
      final svgFinder = find.byType(SvgPicture);
      expect(svgFinder, findsOneWidget);

      final svgWidget = tester.widget<SvgPicture>(svgFinder);
      final assetName = (svgWidget.bytesLoader as SvgAssetLoader).assetName;
      expect(assetName, 'assets/images/rainy.svg');
    });

    testWidgets('最高気温が表示されること', (tester) async {
      // Arrange
      // テスト環境の画面サイズを設定
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const testState = WeatherPageUiState(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 25,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherPageUiStateProvider.overrideWith((ref) => testState),
          ],
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );

      // Act & Assert
      expect(find.text('25 ℃'), findsOneWidget);
    });

    testWidgets('最低気温が表示されること', (tester) async {
      // Arrange
      // テスト環境の画面サイズを設定
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const testState = WeatherPageUiState(
        weatherCondition: 'sunny',
        minTemperature: 10,
        maxTemperature: 25,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherPageUiStateProvider.overrideWith((ref) => testState),
          ],
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );

      // Act & Assert
      expect(find.text('10 ℃'), findsOneWidget);
    });

    testWidgets('エラーメッセージがある場合、ダイアログが表示されること', (tester) async {
      // Arrange
      // テスト環境の画面サイズを設定
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const errorMessage = 'エラーが発生しました';
      const testState = WeatherPageUiState(
        errorMessage: errorMessage,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherPageUiStateProvider.overrideWith((ref) => testState),
          ],
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );

      // Act
      // ダイアログは addPostFrameCallback で表示されるため、pumpAndSettle を使用
      await tester.pumpAndSettle();

      // Assert
      // ダイアログのタイトルとメッセージを確認
      expect(find.text('エラー'), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });
  });
}
