// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WeatherResponse',
      json,
      ($checkedConvert) {
        final val = WeatherResponse(
          weatherCondition: $checkedConvert(
            'weather_condition',
            (v) => v as String,
          ),
          minTemperature: $checkedConvert(
            'min_temperature',
            (v) => (v as num).toInt(),
          ),
          maxTemperature: $checkedConvert(
            'max_temperature',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'minTemperature': 'min_temperature',
        'maxTemperature': 'max_temperature',
      },
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'weather_condition': instance.weatherCondition,
      'min_temperature': instance.minTemperature,
      'max_temperature': instance.maxTemperature,
    };
