import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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

  group('weatherDataSourceのテスト', () {
    test('sunny', () {
      when(yumemiWeatherService.fetchSimpleWeather())
          .thenAnswer((realInvocation) => 'sunny');
      final weatherString = weatherDataSource.fetchWeather();
      expect(weatherString, 'sunny');
    });

    test('cloudy', () {
      when(yumemiWeatherService.fetchSimpleWeather())
          .thenAnswer((realInvocation) => 'cloudy');
      final weatherString = weatherDataSource.fetchWeather();
      expect(weatherString, 'cloudy');
    });

    test('rainy', () {
      when(yumemiWeatherService.fetchSimpleWeather())
          .thenAnswer((realInvocation) => 'rainy');
      final weatherString = weatherDataSource.fetchWeather();
      expect(weatherString, 'rainy');
    });
  });
}
