import 'package:flutter_training/weather/yumemi_weather_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_data_source.g.dart';

@riverpod
WeatherDataSource weatherDataSource(WeatherDataSourceRef ref) {
  final service = ref.watch(yumemiWeatherServiceProvider);
  return WeatherDataSource(service);
}

class WeatherDataSource {
  WeatherDataSource(this._yumemiWeatherService);
  final YumemiWeather _yumemiWeatherService;

  String fetchWeather() {
    return _yumemiWeatherService.fetchSimpleWeather();
  }
}
