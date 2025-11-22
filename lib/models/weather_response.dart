import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  const WeatherResponse({
    required this.weatherCondition,
    required this.minTemperature,
    required this.maxTemperature,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  final String weatherCondition;
  final int minTemperature;
  final int maxTemperature;

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
