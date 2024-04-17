
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/components/action_button.dart';
import 'package:flutter_training/components/weather_information.dart';
import 'package:flutter_training/weather/weather_page_view_model.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherNotifier = ref.read(weatherPageViewModelProvider.notifier);
    return Scaffold(
      // 横に 1:2:1になるようなレイアウトを作る
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Flexible(
            child: SizedBox(),
          ),
          Flexible(
            flex: 2,
            // Expandedで挟むことで WeatherInformationを中央に固定
            child: Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
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
                            onPressed: () {},
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
          const Flexible(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
