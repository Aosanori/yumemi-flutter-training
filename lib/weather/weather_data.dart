import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_data.freezed.dart';
part 'weather_data.g.dart';

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    required WeatherCondition weatherCondition,
    required int maxTemperature,
    required int minTemperature,
    required DateTime date,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}
