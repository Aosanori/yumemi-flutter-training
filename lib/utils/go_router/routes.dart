import 'package:flutter_training/launch/launch_page.dart';
import 'package:flutter_training/weather/weather_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'launch',
      path: '/',
      builder: (context, state) => const LaunchPage(),
      routes: [
        GoRoute(
          name: 'weather',
          path: 'weather',
          builder: (context, state) => const WeatherPage(),
        ),
      ],
    ),
  ],
);
