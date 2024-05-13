import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/exceptions/yumemi_weather_exception.dart';
import 'package:flutter_training/exceptions/yumemi_weather_repository_exception_error.dart';
import 'package:flutter_training/weather/weather_data.dart';
import 'package:flutter_training/weather/weather_page.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_page_view_model_test.mocks.dart';

Finder findWithAssetName(String assetName) => find.byWidgetPredicate(
      (widget) =>
          widget is SvgPicture &&
          (widget.bytesLoader as SvgAssetLoader).assetName == assetName,
    );

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
void main() {
  group('weatherPageの正常系テスト', () {
    testWidgets('初期状態', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => MockWeatherRepository(),
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      expect(find.text('close'), findsOneWidget);
      expect(find.text('reload'), findsOneWidget);
      expect(find.text('** ℃'), findsWidgets);
      expect(
        find.byType(Placeholder),
        findsOneWidget,
      );
    });
    testWidgets('「Reload」ボタンを押したとき、天気予報画面に晴れの画像が表示される', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'sunny',
          'max_temperature': 26,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );

      when(weatherRepository.fetchWeather(any))
          .thenAnswer((realInvocation) => sampleWeatherData);
      await tester.tap(find.text('reload'));
      await tester.pump();

      expect(findWithAssetName('assets/sunny.svg'), findsOneWidget);
      expect(find.text('26 ℃'), findsWidgets);
      expect(
        (tester.firstWidget(find.text('26 ℃')) as Text).style?.color,
        Colors.red,
      );
      expect(find.text('-20 ℃'), findsWidgets);
      expect(
        (tester.firstWidget(find.text('-20 ℃')) as Text).style?.color,
        Colors.blue,
      );
    });

    testWidgets('「Reload」ボタンを押したとき天気予報画面に曇りの画像が表示される', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'cloudy',
          'max_temperature': 20,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );

      when(weatherRepository.fetchWeather(any))
          .thenAnswer((realInvocation) => sampleWeatherData);
      await tester.tap(find.text('reload'));
      await tester.pump();

      expect(findWithAssetName('assets/cloudy.svg'), findsOneWidget);
      expect(find.text('20 ℃'), findsWidgets);
      expect(
        (tester.firstWidget(find.text('20 ℃')) as Text).style?.color,
        Colors.red,
      );
      expect(find.text('-20 ℃'), findsWidgets);
      expect(
        (tester.firstWidget(find.text('-20 ℃')) as Text).style?.color,
        Colors.blue,
      );
    });

    testWidgets('「Reload」ボタンを押したとき、天気予報画面に雨の画像が表示される', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      final sampleWeatherData = WeatherData.fromJson(
        {
          'weather_condition': 'rainy',
          'max_temperature': 16,
          'min_temperature': -20,
          'date': '2024-04-24T16:46:08+09:00',
        },
      );

      when(weatherRepository.fetchWeather(any))
          .thenAnswer((realInvocation) => sampleWeatherData);
      await tester.tap(find.text('reload'));
      await tester.pump();

      expect(findWithAssetName('assets/rainy.svg'), findsOneWidget);
      expect(find.text('16 ℃'), findsWidgets);
      expect(
        (tester.firstWidget(find.text('16 ℃')) as Text).style?.color,
        Colors.red,
      );
      expect(find.text('-20 ℃'), findsWidgets);
      expect(
        (tester.firstWidget(find.text('-20 ℃')) as Text).style?.color,
        Colors.blue,
      );
    });
  });

  group('weatherPageの異常系テスト', () {
    testWidgets('YumemiWeatherError.unknown', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );
      when(weatherRepository.fetchWeather(any))
          .thenThrow(const YumemiWeatherException(YumemiWeatherError.unknown));

      await tester.tap(find.text('reload'));
      await tester.pump();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
        find.text('YumemiWeatherException: Failed to load data'),
        findsOneWidget,
      );
    });

    testWidgets('YumemiWeatherError.invalidParameter', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );
      when(weatherRepository.fetchWeather(any)).thenThrow(
        const YumemiWeatherException(YumemiWeatherError.invalidParameter),
      );

      await tester.tap(find.text('reload'));
      await tester.pump();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
        find.text('YumemiWeatherException: Input parameters are wrong.'),
        findsOneWidget,
      );
    });

    testWidgets('YumemiWeatherRepositoryException', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWith(
              (ref) => weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );
      when(weatherRepository.fetchWeather(any)).thenThrow(
        YumemiWeatherRepositoryException,
      );

      await tester.tap(find.text('reload'));
      await tester.pump();
      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
