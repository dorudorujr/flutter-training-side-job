import 'package:flutter/material.dart';
import 'package:flutter_training/weather_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // lintで指定しているunawaitedが存在しない&待機不要なためwarning無効化
    // ignore: discarded_futures
    WidgetsBinding.instance.endOfFrame.then((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WeatherScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
