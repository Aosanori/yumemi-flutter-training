// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'weather_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherDataRequestImpl _$$WeatherDataRequestImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WeatherDataRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$WeatherDataRequestImpl(
          area: $checkedConvert('area', (v) => v as String),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$WeatherDataRequestImplToJson(
        _$WeatherDataRequestImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
