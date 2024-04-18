import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/weather/weather.dart';
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

  group('weatherRepositoryのテスト', () {
    test('sunny', () {
      when(weatherDataSource.fetchWeather())
          .thenAnswer((realInvocation) => 'sunny');
      final weather = weatherRepository.fetchWeather();
      expect(weather, Weather.sunny);
    });

    test('cloudy', () {
      when(weatherDataSource.fetchWeather())
          .thenAnswer((realInvocation) => 'cloudy');
      final weather = weatherRepository.fetchWeather();
      expect(weather, Weather.cloudy);
    });

    test('rainy', () {
      when(weatherDataSource.fetchWeather())
          .thenAnswer((realInvocation) => 'rainy');
      final weather = weatherRepository.fetchWeather();
      expect(weather, Weather.rainy);
    });

    test('snowy', () {
      when(weatherDataSource.fetchWeather())
          .thenAnswer((realInvocation) => 'snowy');
      final weather = weatherRepository.fetchWeather();
      expect(weather, null);
    });
  });
}
