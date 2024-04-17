import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
                  'aaa',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.blue),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'bbb',
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    child: Container()
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
