import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

// スプラッシュ画面
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WeatherScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}

// 天気画面
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _weatherCondition;
  final _yumemiWeather = YumemiWeather();

  void _fetchWeather() {
    setState(() {
      _weatherCondition = _yumemiWeather.fetchSimpleWeather();
    });
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
                        '** ℃',
                        textAlign: TextAlign.center,
                        style: textStyle?.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 4,
                      child: Text(
                        '** ℃',
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
