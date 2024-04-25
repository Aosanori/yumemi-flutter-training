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

@GenerateNiceMocks([MockSpec<WeatherDataSource>()])
void main() {
  late WeatherDataSource weatherDataSource;
  late ProviderContainer container;
  late WeatherRepository weatherRepository;

  setUp(() {
    weatherDataSource = MockWeatherDataSource();
    container = ProviderContainer(
      overrides: [
        weatherDataSourceProvider.overrideWith((ref) {
          return weatherDataSource;
        }),
      ],
    );
    weatherRepository = container.read(weatherRepositoryProvider);
  });

  final payload = {
    'area': 'tokyo',
    'date': DateTime.now().toIso8601String(),
  };

  final weatherDataRequest = WeatherDataRequest.fromJson(payload);
  final weatherDataPayload = json.encode(payload);

  group('weatherRepositoryの正常系テスト', () {
    test('sunny', () {
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (realInvocation) => json.encode(
          {
            'weather_condition': 'sunny',
            'max_temperature': 33,
            'min_temperature': 20,
            'date': '2024-04-24T12:09:46+09:00',
          },
        ),
      );
      final weather = weatherRepository.fetchWeather(weatherDataRequest);
      expect(weather?.weatherCondition, WeatherCondition.sunny);
      expect(weather?.maxTemperature, 33);
      expect(weather?.minTemperature, 20);
    });

    test('cloudy', () {
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (realInvocation) => json.encode(
          {
            'weather_condition': 'cloudy',
            'max_temperature': 25,
            'min_temperature': 19,
            'date': '2024-04-24T12:09:46+09:00',
          },
        ),
      );
      final weather = weatherRepository.fetchWeather(weatherDataRequest);
      expect(weather?.weatherCondition, WeatherCondition.cloudy);
      expect(weather?.maxTemperature, 25);
      expect(weather?.minTemperature, 19);
    });

    test('rainy', () {
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (realInvocation) => json.encode(
          {
            'weather_condition': 'rainy',
            'max_temperature': 25,
            'min_temperature': 21,
            'date': '2024-04-24T12:09:46+09:00',
          },
        ),
      );
      final weather = weatherRepository.fetchWeather(weatherDataRequest);
      expect(weather?.weatherCondition, WeatherCondition.rainy);
      expect(weather?.maxTemperature, 25);
      expect(weather?.minTemperature, 21);
    });
  });

  group('weatherRepositoryの異常系テスト', () {
    test('snowy', () {
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (realInvocation) => json.encode(
          {
            'weather_condition': 'snowy',
            'max_temperature': 1,
            'min_temperature': -9,
            'date': '2024-04-24T12:09:46+09:00',
          },
        ),
      );
      expect(
        () => weatherRepository.fetchWeather(weatherDataRequest),
        throwsA(
          isA<YumemiWeatherRepositoryException>(),
        ),
      );
    });

    test('Not Appropriate Data Format.', () {
      when(weatherDataSource.fetchWeather(weatherDataPayload)).thenAnswer(
        (realInvocation) => json.encode(
          {
            'weather_condition': 'rainy',
          },
        ),
      );
      expect(
        () => weatherRepository.fetchWeather(weatherDataRequest),
        throwsA(
          isA<YumemiWeatherRepositoryException>(),
        ),
      );
    });
  });
}
