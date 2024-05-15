import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/weather/weather_data.dart';
import 'package:flutter_training/weather/weather_data_request.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_page_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
void main() {
  final weatherDataRequest = WeatherDataRequest(
    area: 'tokyo',
    date: DateTime.now(),
  );

  test('When WeatherRepository returns WeatherCondition.sunny.', () async {
    final weatherRepository = MockWeatherRepository();
    final container = ProviderContainer(
      overrides: [
        weatherRepositoryProvider.overrideWithValue(weatherRepository),
      ],
    );
    addTearDown(container.dispose);
    final sampleWeatherData = WeatherData.fromJson(
      {
        'weather_condition': 'sunny',
        'max_temperature': 26,
        'min_temperature': -20,
        'date': '2024-04-24T16:46:08+09:00',
      },
    );
    when(weatherRepository.fetchWeather(weatherDataRequest))
        .thenAnswer((_) => sampleWeatherData);

    await container
        .read(weatherPageViewModelProvider.notifier)
        .fetchWeather(weatherDataRequest);
    final state = container.read(weatherPageViewModelProvider);

    expect(
      state,
      AsyncData<WeatherData?>(
        sampleWeatherData,
      ),
    );
  });
}
