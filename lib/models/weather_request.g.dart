// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherRequest _$WeatherRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WeatherRequest', json, ($checkedConvert) {
      final val = WeatherRequest(
        area: $checkedConvert('area', (v) => v as String),
        date: $checkedConvert('date', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$WeatherRequestToJson(WeatherRequest instance) =>
    <String, dynamic>{'area': instance.area, 'date': instance.date};
