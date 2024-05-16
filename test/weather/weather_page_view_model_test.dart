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

(MockWeatherRepository, ProviderContainer) setup() {
  final weatherRepository = MockWeatherRepository();
  final container = ProviderContainer(
    overrides: [
      weatherRepositoryProvider.overrideWithValue(weatherRepository),
    ],
  );
  addTearDown(container.dispose);
  return (weatherRepository, container);
}

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
void main() {
  final weatherDataRequest = WeatherDataRequest(
    area: 'tokyo',
    date: DateTime.now(),
  );

  group('weatherPageViewModelの正常系テスト', () {
    test('initialize', () async {
      // Arrange
      final (_, container) = setup();

      // Act
      container.listen(weatherPageViewModelProvider, (_, __) {});

      // Assert
      expect(await container.read(weatherPageViewModelProvider.future), null);
    });

    test('When WeatherRepository returns WeatherCondition.sunny.', () async {
      // Arrange
      final (weatherRepository, container) = setup();

      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'sunny',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((_) async => sampleWeatherData);

      // Act
      await container
          .read(weatherPageViewModelProvider.notifier)
          .fetchWeather(weatherDataRequest);

      // Assert
      expect(
        container.read(weatherPageViewModelProvider),
        AsyncData<WeatherData?>(
          sampleWeatherData,
        ),
      );
    });

    test('When WeatherRepository returns WeatherCondition.cloudy.', () async {
      // Arrange
      final (weatherRepository, container) = setup();

      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'cloudy',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((_) async => sampleWeatherData);

      // Act
      await container
          .read(weatherPageViewModelProvider.notifier)
          .fetchWeather(weatherDataRequest);

      // Assert
      expect(
        container.read(weatherPageViewModelProvider),
        AsyncData<WeatherData?>(
          sampleWeatherData,
        ),
      );
    });

    test('When WeatherRepository returns WeatherCondition.rainy.', () async {
      // Arrange
      final (weatherRepository, container) = setup();

      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'rainy',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((_) async => sampleWeatherData);

      // Act
      await container
          .read(weatherPageViewModelProvider.notifier)
          .fetchWeather(weatherDataRequest);

      // Assert
      expect(
        container.read(weatherPageViewModelProvider),
        AsyncData<WeatherData?>(
          sampleWeatherData,
        ),
      );
    });
  });

  group('weatherPageViewModelの異常系テスト', () {
    test(
        'Set AsyncError(YumemiWeatherError.invalidParameter) '
        'when WeatherRepository throws YumemiWeatherError.invalidParameter.',
        () async {
      // Arrange
      final (weatherRepository, container) = setup();

      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act
      await container
          .read(weatherPageViewModelProvider.notifier)
          .fetchWeather(weatherDataRequest);

      // Assert
      expect(
        container.read(weatherPageViewModelProvider),
        isA<AsyncError<WeatherData?>>(),
      );
      expect(
        container.read(weatherPageViewModelProvider).error,
        YumemiWeatherError.invalidParameter,
      );
    });
  });

  test(
      'Set AsyncError(YumemiWeatherError.unknown) '
      'when WeatherRepository throws YumemiWeatherError.unknown.', () async {
    // Arrange
    final weatherRepository = MockWeatherRepository();
    final container = ProviderContainer(
      overrides: [
        weatherRepositoryProvider.overrideWithValue(weatherRepository),
      ],
    );
    addTearDown(container.dispose);
    when(weatherRepository.fetchWeather(weatherDataRequest))
        .thenThrow(YumemiWeatherError.unknown);

    // Act
    await container
        .read(weatherPageViewModelProvider.notifier)
        .fetchWeather(weatherDataRequest);

    // Assert
    expect(
      container.read(weatherPageViewModelProvider),
      isA<AsyncError<WeatherData?>>(),
    );
    expect(
      container.read(weatherPageViewModelProvider).error,
      YumemiWeatherError.unknown,
    );
  });

  test(
      'Set AsyncError(YumemiWeatherRepositoryException) '
      'when WeatherRepository throws YumemiWeatherRepositoryException.',
      () async {
    // Arrange
    final weatherRepository = MockWeatherRepository();
    final container = ProviderContainer(
      overrides: [
        weatherRepositoryProvider.overrideWithValue(weatherRepository),
      ],
    );
    addTearDown(container.dispose);
    when(weatherRepository.fetchWeather(weatherDataRequest))
        .thenThrow(YumemiWeatherRepositoryException);

    // Act
    await container
        .read(weatherPageViewModelProvider.notifier)
        .fetchWeather(weatherDataRequest);

    // Assert
    expect(
      container.read(weatherPageViewModelProvider),
      isA<AsyncError<WeatherData?>>(),
    );
    expect(
      container.read(weatherPageViewModelProvider).error,
      YumemiWeatherRepositoryException,
    );
  });
}
