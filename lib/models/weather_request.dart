import 'package:json_annotation/json_annotation.dart';

part 'weather_request.g.dart';

@JsonSerializable()
class WeatherRequest {
  const WeatherRequest({
    required this.area,
    required this.date,
  });

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);

  final String area;
  final String date;

  Map<String, dynamic> toJson() => _$WeatherRequestToJson(this);
}
