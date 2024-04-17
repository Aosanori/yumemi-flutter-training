import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherDataSourceProvider = Provider.autoDispose(
  (ref) => WeatherDataSource(),
);

class WeatherDataSource {
  String fetchWeather() {
    return YumemiWeather().fetchSimpleWeather();
  }
}
