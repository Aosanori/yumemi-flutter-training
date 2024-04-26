import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/exceptions/yumemi_weather_repository_exception_error.dart';
import 'package:flutter_training/weather/weather_data.dart';
import 'package:flutter_training/weather/weather_data_request.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_page_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
void main() {
  late WeatherRepository weatherRepository;
  late ProviderContainer container;
  late WeatherPageViewModel weatherPageViewModel;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    container = ProviderContainer(
      overrides: [
        weatherRepositoryProvider.overrideWithValue(weatherRepository),
      ],
    );
    addTearDown(container.dispose);
    weatherPageViewModel =
        container.read(weatherPageViewModelProvider.notifier);
  });

  final weatherDataRequest = WeatherDataRequest(
    area: 'tokyo',
    date: DateTime.now(),
  );

  group('weatherPageViewModelの正常系テスト', () {
    test('initialize', () {
      expect(weatherPageViewModel.state, const AsyncData<WeatherData?>(null));
    });

    test('When WeatherRepository returns WeatherCondition.sunny.', () async {
      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'sunny',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((realInvocation) => sampleWeatherData);
      unawaited(
        weatherPageViewModel.fetchWeather(weatherDataRequest).then(
          (value) {
            expect(
              weatherPageViewModel.state,
              AsyncData<WeatherData?>(
                sampleWeatherData,
              ),
            );
          },
        ),
      );
    });

    test('When WeatherRepository returns WeatherCondition.cloudy.', () async {
      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'cloudy',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((realInvocation) => sampleWeatherData);
      unawaited(
        weatherPageViewModel.fetchWeather(weatherDataRequest).then(
          (value) {
            expect(
              weatherPageViewModel.state,
              AsyncData<WeatherData?>(
                sampleWeatherData,
              ),
            );
          },
        ),
      );
    });

    test('When WeatherRepository returns WeatherCondition.rainy.', () async {
      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'cloudy',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((realInvocation) => sampleWeatherData);
      unawaited(
        weatherPageViewModel.fetchWeather(weatherDataRequest).then(
          (value) {
            expect(
              weatherPageViewModel.state,
              AsyncData<WeatherData?>(
                sampleWeatherData,
              ),
            );
          },
        ),
      );
    });
  });
  group('weatherPageViewModelの異常系テスト', () {
    test(
        'Set AsyncError(YumemiWeatherError.invalidParameter) '
        'when WeatherRepository throws YumemiWeatherError.invalidParameter.',
        () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherError.invalidParameter);
      unawaited(
        weatherPageViewModel.fetchWeather(weatherDataRequest).then((value) {
          expect(
            weatherPageViewModel.state,
            isA<AsyncError<YumemiWeatherError>>(),
          );
        }),
      );
    });

    test(
        'Set AsyncError(YumemiWeatherError.unknown) '
        'when WeatherRepository throws YumemiWeatherError.unknown.', () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherError.unknown);
      unawaited(
        weatherPageViewModel.fetchWeather(weatherDataRequest).then((value) {
          expect(
            weatherPageViewModel.state,
            isA<AsyncError<YumemiWeatherError>>(),
          );
        }),
      );
    });

    test(
        'Set AsyncError(YumemiWeatherRepositoryException) '
        'when WeatherRepository throws YumemiWeatherRepositoryException.',
        () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherRepositoryException);
      unawaited(
        weatherPageViewModel.fetchWeather(weatherDataRequest).then((value) {
          expect(
            weatherPageViewModel.state,
            isA<AsyncError<YumemiWeatherRepositoryException>>(),
          );
        }),
      );
    });
  });
}
