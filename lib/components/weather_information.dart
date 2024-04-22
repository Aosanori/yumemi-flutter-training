import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/utils/assets.gen.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';

/// 中央の天気予報と気温を表示するコンポーネント
class WeatherInformation extends ConsumerWidget {
  const WeatherInformation({super.key});

  Widget weatherImg(Weather weather) => switch (weather) {
        Weather.sunny => Assets.sunny.svg(),
        Weather.cloudy => Assets.cloudy.svg(),
        Weather.rainy => Assets.rainy.svg(),
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelLarge = Theme.of(context).textTheme.labelLarge!;
    final weather = ref.watch(weatherPageViewModelProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: weather != null ? weatherImg(weather) : const Placeholder(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '** ℃',
                style: labelLarge.copyWith(color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '** ℃',
                style: labelLarge.copyWith(color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
