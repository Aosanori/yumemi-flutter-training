import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/utils/enum_by_name_or_null.dart';
import 'package:flutter_training/weather/weather.dart';

void main() {
  group('EnumByNameOrNullのテスト', () {
    test('sunny', () {
      final weather = Weather.values.byNameOrNull('sunny');
      expect(weather, Weather.sunny);
    });

    test('cloudy', () {
      final weather = Weather.values.byNameOrNull('cloudy');
      expect(weather, Weather.cloudy);
    });

    test('rainy', () {
      final weather = Weather.values.byNameOrNull('rainy');
      expect(weather, Weather.rainy);
    });

    test('snowy', () {
      final weather = Weather.values.byNameOrNull('snowy');
      expect(weather, null);
    });

    test('windy', () {
      final weather = Weather.values.byNameOrNull('windy');
      expect(weather, null);
    });
  });
}
