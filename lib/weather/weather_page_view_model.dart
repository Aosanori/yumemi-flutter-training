import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_repository.dart';

final weatherPageViewModelProvider =
    NotifierProvider<WeatherPageViewModel, Weather?>(
  WeatherPageViewModel.new,
);

class WeatherPageViewModel extends Notifier<Weather?> {
  late final WeatherRepository _weatherRepository;

  @override
  Weather? build() {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    return null;
  }

  void fetchWeather() {
    state = _weatherRepository.fetchWeather();
  }
}
