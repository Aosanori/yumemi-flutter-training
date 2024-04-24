import 'package:flutter/material.dart';
import 'package:flutter_training/utils/assets.gen.dart';
import 'package:flutter_training/weather/weather_data.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage(this._weather, {super.key});
  final WeatherCondition _weather;

  @override
  Widget build(BuildContext context) {
    return switch (_weather) {
      WeatherCondition.sunny => Assets.sunny.svg(),
      WeatherCondition.cloudy => Assets.cloudy.svg(),
      WeatherCondition.rainy => Assets.rainy.svg(),
    };
  }
}
