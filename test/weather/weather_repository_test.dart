import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/exceptions/yumemi_weather_repository_exception_error.dart';
import 'package:flutter_training/weather/weather_data.dart';
import 'package:flutter_training/weather/weather_data_request.dart';
import 'package:flutter_training/weather/weather_data_source.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_test.mocks.dart';

(MockWeatherDataSource, WeatherRepository) setup() {
  final weatherDataSource = MockWeatherDataSource();
  final container = ProviderContainer(
    overrides: [
      weatherDataSourceProvider.overrideWithValue(weatherDataSource),
    ],
  );
  addTearDown(container.dispose);
  final weatherRepository = container.read(weatherRepositoryProvider);
  return (weatherDataSource, weatherRepository);
}

@GenerateNiceMocks([MockSpec<WeatherDataSource>()])
void main() {
  /// weatherDataSourceではjsonで入出力する形となっております。
  /// そこでweatherDataSourceとweatherRepositoryへの入力を揃えるために
  /// weatherDataRequestとweatherDataPayloadをそれぞれ一つのMapから生成しました。
  final payload = {
    'area': 'tokyo',
    'date': DateTime.now().toIso8601String(),
  };

  final weatherDataRequest = WeatherDataRequest.fromJson(payload);
  final weatherDataPayload = json.encode(payload);

  group('weatherRepositoryの正常系テスト', () {
    test('When WeatherDataSource returns sunny.', () async {
      // Arrange
      final (weatherDataSource, weatherRepository) = setup();
      
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (_) async => json.encode(
          {
            'weather_condition': 'sunny',
            'max_temperature': 33,
            'min_temperature': 20,
            'date': '2024-04-24T12:09:46',
          },
        ),
      );

      // Act
      final weather = await weatherRepository.fetchWeather(weatherDataRequest);

      // Assert
      expect(
        weather,
        WeatherData(
          weatherCondition: WeatherCondition.sunny,
          maxTemperature: 33,
          minTemperature: 20,
          date: DateTime(2024, 4, 24, 12, 9, 46),
        ),
      );
    });

    test('When WeatherDataSource returns cloudy.', () async {
      // Arrange
      final (weatherDataSource, weatherRepository) = setup();
      
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (_) async => json.encode(
          {
            'weather_condition': 'cloudy',
            'max_temperature': 25,
            'min_temperature': 19,
            'date': '2024-04-24T12:09:46',
          },
        ),
      );

      // Act
      final weather = await weatherRepository.fetchWeather(weatherDataRequest);

      // Assert
      expect(
        weather,
        WeatherData(
          weatherCondition: WeatherCondition.cloudy,
          maxTemperature: 25,
          minTemperature: 19,
          date: DateTime(2024, 4, 24, 12, 9, 46),
        ),
      );
    });

    test('When WeatherDataSource returns rainy.', () async {
      // Arrange
      final (weatherDataSource, weatherRepository) = setup();
      
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (_) async => json.encode(
          {
            'weather_condition': 'rainy',
            'max_temperature': 25,
            'min_temperature': 21,
            'date': '2024-04-24T12:09:46',
          },
        ),
      );

      // Act
      final weather = await weatherRepository.fetchWeather(weatherDataRequest);

      // Assert
      expect(
        weather,
        WeatherData(
          weatherCondition: WeatherCondition.rainy,
          maxTemperature: 25,
          minTemperature: 21,
          date: DateTime(2024, 4, 24, 12, 9, 46),
        ),
      );
    });
  });

  group('weatherRepositoryの異常系テスト', () {
    test(
        'Throws YumemiWeatherRepositoryException '
        'When WeatherDataSource returns snowy. '
        '(including invalid value)', () async {
      // Arrange
      final (weatherDataSource, weatherRepository) = setup();
      
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (_) async => json.encode(
          {
            'weather_condition': 'snowy',
            'max_temperature': 1,
            'min_temperature': -9,
            'date': '2024-04-24T12:09:46',
          },
        ),
      );

      // Act & Assert
      expect(
        () async => weatherRepository.fetchWeather(weatherDataRequest),
        throwsA(
          isA<YumemiWeatherRepositoryException>(),
        ),
      );
    });

    test(
        'Throws YumemiWeatherRepositoryException '
        'When the data is not appropriate format.', () async {
      // Arrange
      final (weatherDataSource, weatherRepository) = setup();
      
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (_) async => json.encode(
          {
            'weather_condition': 'rainy',
          },
        ),
      );

      // Act & Assert
      expect(
        () async => weatherRepository.fetchWeather(weatherDataRequest),
        throwsA(
          isA<YumemiWeatherRepositoryException>(),
        ),
      );
    });
  });
}
