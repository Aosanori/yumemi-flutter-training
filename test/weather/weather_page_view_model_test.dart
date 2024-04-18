import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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

  group('weatherPageViewModelのテスト', () {
    test('initialize', () {
      expect(weatherPageViewModel.state, null);
    });

    test('sunny', () {
      when(weatherRepository.fetchWeather())
          .thenAnswer((realInvocation) => Weather.sunny);
      weatherPageViewModel.fetchWeather();
      expect(weatherPageViewModel.state, Weather.sunny);
    });

    test('cloudy', () {
      when(weatherRepository.fetchWeather())
          .thenAnswer((realInvocation) => Weather.cloudy);
      weatherPageViewModel.fetchWeather();
      expect(weatherPageViewModel.state, Weather.cloudy);
    });

    test('rainy', () {
      when(weatherRepository.fetchWeather())
          .thenAnswer((realInvocation) => Weather.rainy);
      weatherPageViewModel.fetchWeather();
      expect(weatherPageViewModel.state, Weather.rainy);
    });

    test('null', () {
      when(weatherRepository.fetchWeather())
          .thenAnswer((realInvocation) => null);
      weatherPageViewModel.fetchWeather();
      expect(weatherPageViewModel.state, null);
    });
  });
}
