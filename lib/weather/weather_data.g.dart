// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherDataImpl _$$WeatherDataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WeatherDataImpl',
      json,
      ($checkedConvert) {
        final val = _$WeatherDataImpl(
          weatherCondition: $checkedConvert('weather_condition',
              (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
          maxTemperature: $checkedConvert('max_temperature', (v) => v as int),
          minTemperature: $checkedConvert('min_temperature', (v) => v as int),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature'
      },
    );

Map<String, dynamic> _$$WeatherDataImplToJson(_$WeatherDataImpl instance) =>
    <String, dynamic>{
      'weather_condition':
          _$WeatherConditionEnumMap[instance.weatherCondition]!,
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
      'date': instance.date.toIso8601String(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
};
