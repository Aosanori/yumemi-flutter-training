import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'yumemi_weather_service.g.dart';

@riverpod
YumemiWeather yumemiWeatherService(YumemiWeatherServiceRef ref) {
  return YumemiWeather();
}
