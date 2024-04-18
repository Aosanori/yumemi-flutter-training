import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Weather fetchWeather() {
    //   try {
    //     return Weather.values.byName(weatherString);
    //   } on Exception catch (_, e) {}
    final weatherString = _weatherDataSource.fetchWeather();
    final weather = Weather.values.byName(weatherString);
    return weather;
  }
}
