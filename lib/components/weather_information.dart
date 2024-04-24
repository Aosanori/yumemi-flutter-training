import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/components/temperature_display.dart';
import 'package:flutter_training/components/weather_image.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';

/// 中央の天気予報と気温を表示するコンポーネント
class WeatherInformation extends ConsumerWidget {
  const WeatherInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherPageViewModelProvider);
    final weatherData = weatherState.valueOrNull;
    /// APIのエラー時に表示するダイアログ
    ref.listen(
      weatherPageViewModelProvider,
      (previous, next) async {
        await next.maybeWhen(
          error: (error, _) async => showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (context) {
              return AlertDialog(
                title: Text(error.toString()),
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
          ),
          orElse: () {},
        );
      },
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: weatherData != null
              ? WeatherImage(weatherData.weatherCondition)
              : const Placeholder(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TemperatureDisplay(
              temperature: weatherData?.minTemperature,
              textColor: Colors.blue,
            ),
            TemperatureDisplay(
              temperature: weatherData?.maxTemperature,
              textColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
