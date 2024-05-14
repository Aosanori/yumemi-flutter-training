import 'package:flutter/foundation.dart';
import 'package:flutter_training/weather/weather_data.dart';
import 'package:flutter_training/weather/weather_data_request.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_page_view_model.g.dart';

@Riverpod(keepAlive: true)
class WeatherPageViewModel extends _$WeatherPageViewModel {
  @override
  Future<WeatherData?> build() async => null;

  Future<void> fetchWeather(WeatherDataRequest weatherDataRequest) async {
    final weatherRepository = ref.read(weatherRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return compute(weatherRepository.fetchWeather, weatherDataRequest);
    });
  }
}
