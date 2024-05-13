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
            weatherRepositoryProvider.overrideWithValue(
              MockWeatherRepository(),
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
            weatherRepositoryProvider.overrideWithValue(
              weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      final sampleWeatherData = WeatherData(
        weatherCondition: WeatherCondition.sunny,
        maxTemperature: 26,
        minTemperature: -20,
        date: DateTime(2024, 4, 24, 16, 46, 08),
      );

      when(weatherRepository.fetchWeather(any))
          .thenAnswer((_) => sampleWeatherData);
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
            weatherRepositoryProvider.overrideWithValue(
              weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      final sampleWeatherData = WeatherData(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 20,
        minTemperature: -20,
        date: DateTime(2024, 4, 24, 16, 46, 08),
      );

      when(weatherRepository.fetchWeather(any))
          .thenAnswer((_) => sampleWeatherData);
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
            weatherRepositoryProvider.overrideWithValue(
              weatherRepository,
            ),
          ],
          child: const MaterialApp(
            home: WeatherPage(),
          ),
        ),
      );

      final sampleWeatherData = WeatherData(
        weatherCondition: WeatherCondition.rainy,
        maxTemperature: 16,
        minTemperature: -20,
        date: DateTime(2024, 4, 24, 16, 46, 08),
      );

      when(weatherRepository.fetchWeather(any))
          .thenAnswer((_) => sampleWeatherData);
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
    testWidgets(
        '「Reload」ボタンを押し、YumemiWeatherError.unknownが発生した場合、'
        'エラー内容をAlertDialogで表示する', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWithValue(
              weatherRepository,
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

    testWidgets(
        '「Reload」ボタンを押し、YumemiWeatherError.invalidParameterが発生した場合、'
        'エラー内容をAlertDialogで表示する', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWithValue(
              weatherRepository,
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

    testWidgets(
        '「Reload」ボタンを押し、YumemiWeatherRepositoryExceptionが発生した場合、'
        'エラー内容をAlertDialogで表示する', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      final weatherRepository = MockWeatherRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWithValue(
              weatherRepository,
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
