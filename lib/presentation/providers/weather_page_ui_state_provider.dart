import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/repositories/weather_ui_state_repository.dart';
import 'package:flutter_training/presentation/ui_state/weather_page_ui_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_page_ui_state_provider.g.dart';

/// 天気ページのUI状態を提供するProvider
@riverpod
WeatherPageUiState weatherPageUiState(Ref ref) {
  return ref.watch(weatherUiStateRepositoryProvider);
}
