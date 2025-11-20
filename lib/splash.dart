import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training/post_layout_callback_mixin.dart';
import 'package:flutter_training/weather_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with PostLayoutCallbackMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }

  @override
  void onPostLayout() {
    unawaited(_waitAndNavigate());
  }

  Future<void> _waitAndNavigate() async {
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
