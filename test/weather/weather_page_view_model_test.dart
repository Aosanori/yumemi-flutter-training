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
        weatherRepositoryProvider.overrideWith((ref) => weatherRepository),
      ],
    );
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

    test('sunny', () async {
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
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(
        weatherPageViewModel.state,
        AsyncData<WeatherData?>(
          sampleWeatherData,
        ),
      );
    });

    test('cloudy', () async {
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
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(
        weatherPageViewModel.state,
        AsyncData<WeatherData?>(
          sampleWeatherData,
        ),
      );
    });

    test('rainy', () async {
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
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(
        weatherPageViewModel.state,
        AsyncData<WeatherData?>(
          sampleWeatherData,
        ),
      );
    });
  });
  group('weatherPageViewModelの異常系テスト', () {
    test('null', () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenAnswer((realInvocation) => null);
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(
        weatherPageViewModel.state,
        const AsyncData<WeatherData?>(null),
      );
    });

    test('YumemiWeatherError.invalidParameter', () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherError.invalidParameter);
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(weatherPageViewModel.state is AsyncError, true);
      expect(
        weatherPageViewModel.state.error,
        YumemiWeatherError.invalidParameter,
      );
    });

    test('YumemiWeatherError.unknown', () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherError.unknown);
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(weatherPageViewModel.state is AsyncError, true);
      expect(
        weatherPageViewModel.state.error,
        YumemiWeatherError.unknown,
      );
    });

    test('YumemiWeatherRepositoryException', () async {
      when(weatherRepository.fetchWeather(weatherDataRequest))
          .thenThrow(YumemiWeatherRepositoryException);
      await weatherPageViewModel.fetchWeather(weatherDataRequest);
      expect(weatherPageViewModel.state is AsyncError, true);
      expect(
        weatherPageViewModel.state.error,
        YumemiWeatherRepositoryException,
      );
    });
  });
}
