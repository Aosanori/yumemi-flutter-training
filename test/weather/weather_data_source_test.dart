import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/exceptions/yumemi_weather_exception.dart';
import 'package:flutter_training/weather/weather_data_source.dart';
import 'package:flutter_training/weather/yumemi_weather_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  late YumemiWeather yumemiWeatherService;
  late ProviderContainer container;
  late WeatherDataSource weatherDataSource;

  setUp(() {
    yumemiWeatherService = MockYumemiWeather();
    container = ProviderContainer(
      overrides: [
        yumemiWeatherServiceProvider.overrideWith((ref) {
          return yumemiWeatherService;
        }),
      ],
    );
    weatherDataSource = container.read(weatherDataSourceProvider);
  });

  final payload = json.encode(
    {
      'area': 'tokyo',
      'date': DateTime.now().toIso8601String(),
    },
  );

  group('weatherDataSourceの正常系テスト', () {
    test('sunny', () {
      final response = json.encode(
        {
          'weather_condition': 'sunny',
          'max_temperature': 33,
          'min_temperature': 20,
          'date': '2024-04-24T12:09:46+09:00',
        },
      );
      when(yumemiWeatherService.fetchWeather(payload))
          .thenAnswer((_) => response);
      final weatherString = weatherDataSource.fetchWeather(payload);
      expect(weatherString, response);
    });
    test('cloudy', () {
      final response = json.encode(
        {
          'weather_condition': 'cloudy',
          'max_temperature': 33,
          'min_temperature': 20,
          'date': '2024-04-24T12:09:46+09:00',
        },
      );
      when(yumemiWeatherService.fetchWeather(payload))
          .thenAnswer((_) => response);
      final weatherString = weatherDataSource.fetchWeather(payload);
      expect(weatherString, response);
    });
    test('rainy', () {
      final response = json.encode(
        {
          'weather_condition': 'rainy',
          'max_temperature': 33,
          'min_temperature': 20,
          'date': '2024-04-24T12:09:46+09:00',
        },
      );
      when(yumemiWeatherService.fetchWeather(payload))
          .thenAnswer((_) => response);
      final weatherString = weatherDataSource.fetchWeather(payload);
      expect(weatherString, response);
    });
  });

  group('weatherDataSourceの異常系テスト', () {
    test('YumemiWeatherError.invalidParameter', () {
      when(yumemiWeatherService.fetchWeather(payload))
          .thenThrow(YumemiWeatherError.invalidParameter);

      expect(
        () => weatherDataSource.fetchWeather(payload),
        throwsA(
          predicate(
            (e) =>
                e is YumemiWeatherException &&
                e.message == 'Input parameters are wrong.',
          ),
        ),
      );
    });

    test('YumemiWeatherError.unknown', () {
      when(yumemiWeatherService.fetchWeather(payload))
          .thenThrow(YumemiWeatherError.unknown);
      expect(
        () => weatherDataSource.fetchWeather(payload),
        throwsA(
          predicate(
            (e) =>
                e is YumemiWeatherException &&
                e.message == 'Failed to load data',
          ),
        ),
      );
    });
  });
}