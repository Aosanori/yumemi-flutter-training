import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/components/action_button.dart';
import 'package:flutter_training/components/weather_information.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';
import 'package:go_router/go_router.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherNotifier = ref.read(weatherPageViewModelProvider.notifier);
    return Scaffold(
      // 真ん中で2:1の領域を作る
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              const WeatherInformation(),
              Expanded(
                child: Column(
                  // SizedBoxを用いて
                  // WeatherInformationとActionButtonの隙間を作る
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          buttonTitle: 'close',
                          onPressed: () {
                            context.pop('/');
                          },
                        ),
                        ActionButton(
                          buttonTitle: 'reload',
                          onPressed: weatherNotifier.fetchWeather,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
