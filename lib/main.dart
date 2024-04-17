import 'package:flutter/material.dart';
import 'package:flutter_training/components/action_button.dart';
import 'package:flutter_training/components/weather_information.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
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
                              onPressed: () {},
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
      ),
    );
  }
}
