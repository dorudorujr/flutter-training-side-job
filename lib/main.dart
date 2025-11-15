import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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

                // ---- Placeholder ----
                SizedBox(
                  width: placeholderSize,
                  height: placeholderSize,
                  child: const Placeholder(),
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
                      onPressed: () {},
                      child: const Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
