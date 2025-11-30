// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_ui_state_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherUiStateRepositoryHash() =>
    r'1d7b4ff7d275870c45009455f48c1325cb3df700';

/// 天気ページのUI状態を管理するリポジトリ
///
/// Copied from [WeatherUiStateRepository].
@ProviderFor(WeatherUiStateRepository)
final weatherUiStateRepositoryProvider =
    NotifierProvider<WeatherUiStateRepository, WeatherPageUiState>.internal(
      WeatherUiStateRepository.new,
      name: r'weatherUiStateRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weatherUiStateRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WeatherUiStateRepository = Notifier<WeatherPageUiState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
