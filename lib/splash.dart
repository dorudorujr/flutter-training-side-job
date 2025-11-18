import 'dart:async';
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

    unawaited(
        _waitAndNavigate()
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }

  Future<void> _waitAndNavigate() async {
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => const WeatherScreen(),
        ),
      );
    }
  }
}
