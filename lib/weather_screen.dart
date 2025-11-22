import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _weatherCondition;
  int? _minTemperature;
  int? _maxTemperature;
  final _yumemiWeather = YumemiWeather();

  void _fetchWeather() {
    try {
      final requestJson = jsonEncode({
        'area': 'tokyo',
        'date': DateTime.now().toIso8601String(),
      });

      final responseJson = _yumemiWeather.fetchWeather(requestJson);
      final response = jsonDecode(responseJson) as Map<String, dynamic>;

      setState(() {
        _weatherCondition = response['weather_condition'] as String?;
        _minTemperature = response['min_temperature'] as int?;
        _maxTemperature = response['max_temperature'] as int?;
      });
    } on YumemiWeatherError catch (e) {
      _showErrorDialog(e);
    }
  }

  void _showErrorDialog(YumemiWeatherError error) {
    final message = switch (error) {
      YumemiWeatherError.invalidParameter => '無効なパラメータが指定されました。',
      YumemiWeatherError.unknown => '予期しないエラーが発生しました。\nもう一度お試しください。',
    };

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
        )
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: _weatherCondition == null
                      ? const Placeholder()
                      : SvgPicture.asset(
                          'assets/images/$_weatherCondition.svg'
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
                        _minTemperature != null ? '$_minTemperature ℃' : '** ℃',
                        textAlign: TextAlign.center,
                        style: textStyle?.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 4,
                      child: Text(
                        _maxTemperature != null ? '$_maxTemperature ℃' : '** ℃',
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
                      onPressed: _fetchWeather,
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
