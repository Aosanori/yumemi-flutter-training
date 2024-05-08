import 'dart:convert';

import 'package:flutter_training/exceptions/yumemi_weather_repository_exception_error.dart';
import 'package:flutter_training/weather/weather_data.dart';
import 'package:flutter_training/weather/weather_data_request.dart';
import 'package:flutter_training/weather/weather_data_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  WeatherData? fetchWeather(WeatherDataRequest weatherDataRequest) {
    final payload = json.encode(weatherDataRequest.toJson());
    final weatherString = _weatherDataSource.fetchWeather(payload);
    try {
      final weatherJson = json.decode(weatherString) as Map<String, dynamic>;
      final weatherData = WeatherData.fromJson(weatherJson);
      return weatherData;
    } on CheckedFromJsonException catch (_) {
      throw const YumemiWeatherRepositoryException('invalid data detected.');
    }
  }
}
