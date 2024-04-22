import 'package:flutter/material.dart';
import 'package:flutter_training/utils/assets.gen.dart';
import 'package:flutter_training/weather/weather.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage(this._weather, {super.key});
  final Weather _weather;

  @override
  Widget build(BuildContext context) {
    return switch (_weather) {
      Weather.sunny => Assets.sunny.svg(),
      Weather.cloudy => Assets.cloudy.svg(),
      Weather.rainy => Assets.rainy.svg(),
    };
  }
}
