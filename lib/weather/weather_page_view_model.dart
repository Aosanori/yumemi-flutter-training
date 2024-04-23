import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_page_view_model.g.dart';

@riverpod
class WeatherPageViewModel extends _$WeatherPageViewModel {
  @override
  Future<Weather?> build() async {
    return null;
  }

  Future<void> fetchWeather() async {
    final weatherRepository = ref.read(weatherRepositoryProvider);
    state = await AsyncValue.guard(() async {
      return weatherRepository.fetchWeather();
    });
  }
}
