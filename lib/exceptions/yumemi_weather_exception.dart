import 'package:yumemi_weather/yumemi_weather.dart';

class YumemiWeatherException implements Exception {
  const YumemiWeatherException(this.error);
  final YumemiWeatherError error;

  String get message => switch (error) {
        YumemiWeatherError.invalidParameter => 'Input parameters are wrong.',
        YumemiWeatherError.unknown => 'Failed to load data',
      };

  @override
  String toString() => 'YumemiWeatherException: $message';
}
