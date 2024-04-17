import 'package:flutter/material.dart';

// 中央の天気予報と気温を表示するコンポーネント
class WeatherInformation extends StatelessWidget {
  const WeatherInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(context).textTheme.labelLarge!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
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
