// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_page_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeatherPageUiState {
  /// 天気の状態（sunny, cloudy, rainy）
  String? get weatherCondition => throw _privateConstructorUsedError;

  /// 最低気温
  int? get minTemperature => throw _privateConstructorUsedError;

  /// 最高気温
  int? get maxTemperature => throw _privateConstructorUsedError;

  /// ローディング中かどうか
  bool get isLoading => throw _privateConstructorUsedError;

  /// エラーメッセージ
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of WeatherPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherPageUiStateCopyWith<WeatherPageUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherPageUiStateCopyWith<$Res> {
  factory $WeatherPageUiStateCopyWith(
    WeatherPageUiState value,
    $Res Function(WeatherPageUiState) then,
  ) = _$WeatherPageUiStateCopyWithImpl<$Res, WeatherPageUiState>;
  @useResult
  $Res call({
    String? weatherCondition,
    int? minTemperature,
    int? maxTemperature,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class _$WeatherPageUiStateCopyWithImpl<$Res, $Val extends WeatherPageUiState>
    implements $WeatherPageUiStateCopyWith<$Res> {
  _$WeatherPageUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherCondition = freezed,
    Object? minTemperature = freezed,
    Object? maxTemperature = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            weatherCondition: freezed == weatherCondition
                ? _value.weatherCondition
                : weatherCondition // ignore: cast_nullable_to_non_nullable
                      as String?,
            minTemperature: freezed == minTemperature
                ? _value.minTemperature
                : minTemperature // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxTemperature: freezed == maxTemperature
                ? _value.maxTemperature
                : maxTemperature // ignore: cast_nullable_to_non_nullable
                      as int?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeatherPageUiStateImplCopyWith<$Res>
    implements $WeatherPageUiStateCopyWith<$Res> {
  factory _$$WeatherPageUiStateImplCopyWith(
    _$WeatherPageUiStateImpl value,
    $Res Function(_$WeatherPageUiStateImpl) then,
  ) = __$$WeatherPageUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? weatherCondition,
    int? minTemperature,
    int? maxTemperature,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class __$$WeatherPageUiStateImplCopyWithImpl<$Res>
    extends _$WeatherPageUiStateCopyWithImpl<$Res, _$WeatherPageUiStateImpl>
    implements _$$WeatherPageUiStateImplCopyWith<$Res> {
  __$$WeatherPageUiStateImplCopyWithImpl(
    _$WeatherPageUiStateImpl _value,
    $Res Function(_$WeatherPageUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherCondition = freezed,
    Object? minTemperature = freezed,
    Object? maxTemperature = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$WeatherPageUiStateImpl(
        weatherCondition: freezed == weatherCondition
            ? _value.weatherCondition
            : weatherCondition // ignore: cast_nullable_to_non_nullable
                  as String?,
        minTemperature: freezed == minTemperature
            ? _value.minTemperature
            : minTemperature // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxTemperature: freezed == maxTemperature
            ? _value.maxTemperature
            : maxTemperature // ignore: cast_nullable_to_non_nullable
                  as int?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WeatherPageUiStateImpl implements _WeatherPageUiState {
  const _$WeatherPageUiStateImpl({
    this.weatherCondition,
    this.minTemperature,
    this.maxTemperature,
    this.isLoading = false,
    this.errorMessage,
  });

  /// 天気の状態（sunny, cloudy, rainy）
  @override
  final String? weatherCondition;

  /// 最低気温
  @override
  final int? minTemperature;

  /// 最高気温
  @override
  final int? maxTemperature;

  /// ローディング中かどうか
  @override
  @JsonKey()
  final bool isLoading;

  /// エラーメッセージ
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WeatherPageUiState(weatherCondition: $weatherCondition, minTemperature: $minTemperature, maxTemperature: $maxTemperature, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherPageUiStateImpl &&
            (identical(other.weatherCondition, weatherCondition) ||
                other.weatherCondition == weatherCondition) &&
            (identical(other.minTemperature, minTemperature) ||
                other.minTemperature == minTemperature) &&
            (identical(other.maxTemperature, maxTemperature) ||
                other.maxTemperature == maxTemperature) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    weatherCondition,
    minTemperature,
    maxTemperature,
    isLoading,
    errorMessage,
  );

  /// Create a copy of WeatherPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherPageUiStateImplCopyWith<_$WeatherPageUiStateImpl> get copyWith =>
      __$$WeatherPageUiStateImplCopyWithImpl<_$WeatherPageUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _WeatherPageUiState implements WeatherPageUiState {
  const factory _WeatherPageUiState({
    final String? weatherCondition,
    final int? minTemperature,
    final int? maxTemperature,
    final bool isLoading,
    final String? errorMessage,
  }) = _$WeatherPageUiStateImpl;

  /// 天気の状態（sunny, cloudy, rainy）
  @override
  String? get weatherCondition;

  /// 最低気温
  @override
  int? get minTemperature;

  /// 最高気温
  @override
  int? get maxTemperature;

  /// ローディング中かどうか
  @override
  bool get isLoading;

  /// エラーメッセージ
  @override
  String? get errorMessage;

  /// Create a copy of WeatherPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherPageUiStateImplCopyWith<_$WeatherPageUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
