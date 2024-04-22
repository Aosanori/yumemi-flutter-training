import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/components/weather_image.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';

/// 中央の天気予報と気温を表示するコンポーネント
class WeatherInformation extends ConsumerWidget {
  const WeatherInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelLarge = Theme.of(context).textTheme.labelLarge!;
    final weatherState = ref.watch(weatherPageViewModelProvider);
    final weather = weatherState.valueOrNull;
    /// APIのエラー時に表示するダイアログ
    ref.listen(
      weatherPageViewModelProvider,
      (previous, next) async {
        if (next is AsyncError) {
          await showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (context) {
              return AlertDialog(
                title: Text(next.asError!.error.toString()),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: weather != null ?  WeatherImage(weather) : const Placeholder(),
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
