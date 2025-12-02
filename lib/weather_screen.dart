import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/domain/use_cases/fetch_weather_use_case.dart';
import 'package:flutter_training/presentation/providers/weather_page_ui_state_provider.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  void _showErrorDialog(BuildContext context, String message) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('エラー'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(weatherPageUiStateProvider);

    // エラーメッセージがある場合、ダイアログを表示
    if (uiState.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(context, uiState.errorMessage!);
      });
    }

    return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // サイズ定義
            final placeholderSize = constraints.maxWidth / 2;
            const imageTextSpacing = 16.0;
            const textButtonSpacing = 80.0;

            // TextPainter で Text の高さを計算
            final textStyle = Theme.of(context).textTheme.labelLarge;
            final textPainter = TextPainter(
              text: TextSpan(
                text: '** ℃',
                style: textStyle,
              ),
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth / 4);

            final textHeight = textPainter.height;

            // Placeholder + Text の矩形の高さ
            final contentHeight =
                placeholderSize + imageTextSpacing + textHeight;

            // Placeholder + Text の中央を画面の中央にするための topPadding
            final topPadding = (constraints.maxHeight - contentHeight) / 2;

            return Column(
              children: [
                SizedBox(height: topPadding),

                // ---- Weather Icon ----
                SizedBox(
                  width: placeholderSize,
                  height: placeholderSize,
                  child: uiState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : uiState.weatherCondition == null
                          ? const Placeholder()
                          : SvgPicture.asset(
                              'assets/images/${uiState.weatherCondition}.svg'
                            ),
                ),

                const SizedBox(height: imageTextSpacing),

                // ---- Text ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth / 4,
                      child: Text(
                        uiState.minTemperature != null
                            ? '${uiState.minTemperature} ℃'
                            : '** ℃',
                        textAlign: TextAlign.center,
                        style: textStyle?.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 4,
                      child: Text(
                        uiState.maxTemperature != null
                            ? '${uiState.maxTemperature} ℃'
                            : '** ℃',
                        textAlign: TextAlign.center,
                        style: textStyle?.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),

                // ---- Text と Button の間 ----
                const SizedBox(height: textButtonSpacing),

                // ---- ボタン行 ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {
                        unawaited(
                          ref.read(fetchWeatherUseCaseProvider).execute(),
                        );
                      },
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
  }
}
