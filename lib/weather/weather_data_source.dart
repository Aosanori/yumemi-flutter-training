import 'dart:convert';

import 'package:flutter_training/exceptions/yumemi_weather_exception.dart';
import 'package:flutter_training/weather/yumemi_weather_service.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_logger/simple_logger.dart';
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

  static final payload = {
    'area': 'tokyo',
    'date': DateFormat('yyyy-MM-dd hh:mm:ss').format(
      DateTime(2023, 4, 1, 15, 30),
    ),
  };

  String fetchWeather() {
    try {
      SimpleLogger()
          .info('Getting weather data from Yumemi Weather Service...');
      final weatherData =
          _yumemiWeatherService.fetchWeather(json.encode(payload));
      SimpleLogger()
          .info('Complete to get weather data from Yumemi Weather Service!');
      return weatherData;
    } on YumemiWeatherError catch (e) {
      SimpleLogger().shout('Failed to get data.');
      throw YumemiWeatherException(e);
    }
  }
}
