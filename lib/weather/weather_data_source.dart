import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/weather/yumemi_weather_service.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherDataSourceProvider = Provider.autoDispose(
  (ref) => WeatherDataSource(ref.watch(yumemiWeatherServiceProvider)),
);

class WeatherDataSource {
  WeatherDataSource(this._yumemiWeatherService);
  final YumemiWeather _yumemiWeatherService;

  String fetchWeather() {
    return _yumemiWeatherService.fetchSimpleWeather();
  }
}
