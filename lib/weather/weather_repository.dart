import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/utils/enum_by_name_or_null.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_data_source.dart';

final weatherRepositoryProvider = Provider.autoDispose(
  (ref) => WeatherRepository(
    ref.watch(weatherDataSourceProvider),
  ),
);

class WeatherRepository {
  WeatherRepository(this._weatherDataSource);
  final WeatherDataSource _weatherDataSource;

  Weather? fetchWeather() {
    final weatherString = _weatherDataSource.fetchWeather();
    final weather = Weather.values.byNameOrNull(weatherString);
    return weather;
  }
}
