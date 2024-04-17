import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  Widget weatherInformation(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AspectRatio(
            aspectRatio: 1,
            child: Placeholder(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '** ℃',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.blue),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '** ℃',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      );

  Widget actionButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'close',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton(onPressed: () {}, child: const Text('reload')),
          ),
        ],
      );

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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Flexible(
              child: SizedBox(),
            ),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  weatherInformation(context),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        actionButton(context),
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
