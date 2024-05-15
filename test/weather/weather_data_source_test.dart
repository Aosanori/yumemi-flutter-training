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
  final payload = json.encode(
    {
      'area': 'tokyo',
      'date': DateTime.now().toIso8601String(),
    },
  );

  group('weatherDataSourceの正常系テスト', () {
    test('When YumemiWeatherService returns sunny.', () async {
      // Arrange
      final yumemiWeatherService = MockYumemiWeather();
      final container = ProviderContainer(
        overrides: [
          yumemiWeatherServiceProvider.overrideWithValue(yumemiWeatherService),
        ],
      );
      addTearDown(container.dispose);
      final weatherDataSource = container.read(weatherDataSourceProvider);
      final response = json.encode(
        {
          'weather_condition': 'sunny',
          'max_temperature': 33,
          'min_temperature': 20,
          'date': '2024-04-24T12:09:46+09:00',
        },
      );
      when(yumemiWeatherService.syncFetchWeather(payload)).thenReturn(response);

      // Act
      final weatherString = await weatherDataSource.fetchWeather(payload);

      // Assert
      expect(weatherString, response);
    });
    test('When YumemiWeatherService returns cloudy.', () async {
      // Arrange
      final yumemiWeatherService = MockYumemiWeather();
      final container = ProviderContainer(
        overrides: [
          yumemiWeatherServiceProvider.overrideWithValue(yumemiWeatherService),
        ],
      );
      addTearDown(container.dispose);
      final weatherDataSource = container.read(weatherDataSourceProvider);
      final response = json.encode(
        {
          'weather_condition': 'cloudy',
          'max_temperature': 33,
          'min_temperature': 20,
          'date': '2024-04-24T12:09:46+09:00',
        },
      );
      when(yumemiWeatherService.syncFetchWeather(payload))
          .thenReturn(response);

      // Act
      final weatherString = await weatherDataSource.fetchWeather(payload);

      // Assert
      expect(weatherString, response);
    });
    test('When YumemiWeatherService returns rainy.', () async {
      // Arrange
      final yumemiWeatherService = MockYumemiWeather();
      final container = ProviderContainer(
        overrides: [
          yumemiWeatherServiceProvider.overrideWithValue(yumemiWeatherService),
        ],
      );
      addTearDown(container.dispose);
      final weatherDataSource = container.read(weatherDataSourceProvider);
      final response = json.encode(
        {
          'weather_condition': 'rainy',
          'max_temperature': 33,
          'min_temperature': 20,
          'date': '2024-04-24T12:09:46+09:00',
        },
      );
      when(yumemiWeatherService.syncFetchWeather(payload))
          .thenReturn(response);

      // Act
      final weatherString = await weatherDataSource.fetchWeather(payload);

      // Assert
      expect(weatherString, response);
    });
  });

  group('weatherDataSourceの異常系テスト', () {
    test(
        'Throws YumemiWeatherException '
        'with message of "Input parameters are wrong." '
        'when YumemiWeatherError.invalidParameter is thrown.', () {
      // Arrange
      final yumemiWeatherService = MockYumemiWeather();
      final container = ProviderContainer(
        overrides: [
          yumemiWeatherServiceProvider.overrideWithValue(yumemiWeatherService),
        ],
      );
      addTearDown(container.dispose);
      final weatherDataSource = container.read(weatherDataSourceProvider);
      when(yumemiWeatherService.syncFetchWeather(payload))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act & Assert
      expect(
        () async => weatherDataSource.fetchWeather(payload),
        throwsA(
          predicate(
            (e) =>
                e is YumemiWeatherException &&
                e.message == 'Input parameters are wrong.',
          ),
        ),
      );
    });

    test(
        'Throws YumemiWeatherException '
        'with message of "Failed to load data" '
        'when YumemiWeatherError.unknown is thrown.', () {
      // Arrange
      final yumemiWeatherService = MockYumemiWeather();
      final container = ProviderContainer(
        overrides: [
          yumemiWeatherServiceProvider.overrideWithValue(yumemiWeatherService),
        ],
      );
      addTearDown(container.dispose);
      final weatherDataSource = container.read(weatherDataSourceProvider);
      when(yumemiWeatherService.syncFetchWeather(payload))
          .thenThrow(YumemiWeatherError.unknown);

      // Act & Assert
      expect(
        () async => weatherDataSource.fetchWeather(payload),
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
