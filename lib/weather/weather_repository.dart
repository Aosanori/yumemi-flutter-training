import 'package:flutter_training/exceptions/yumemi_weather_repository_exception_error.dart';
import 'package:flutter_training/utils/enum_by_name_or_null.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_repository.g.dart';

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  final service = ref.watch(weatherDataSourceProvider);
  return WeatherRepository(service);
}

class WeatherRepository {
  WeatherRepository(this._weatherDataSource);
  final WeatherDataSource _weatherDataSource;

  Weather? fetchWeather() {
    final weatherString = _weatherDataSource.fetchWeather();
    final weather = Weather.values.byNameOrNull(weatherString);
    if (weather == null) {
      throw const YumemiWeatherRepositoryException('invalid weather detected.');
    }
    return weather;
  }
}
