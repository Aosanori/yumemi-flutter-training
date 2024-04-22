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

  void fetchWeather() {
    final weatherRepository = ref.read(weatherRepositoryProvider);
    try {
      state = AsyncData(weatherRepository.fetchWeather());
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
