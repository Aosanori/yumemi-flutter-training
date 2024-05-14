// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_training/test/weather/weather_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_training/weather/weather_data.dart' as _i2;
import 'package:flutter_training/weather/weather_data_request.dart' as _i4;
import 'package:flutter_training/weather/weather_repository.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherData_0 extends _i1.SmartFake implements _i2.WeatherData {
  _FakeWeatherData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  @override
  _i2.WeatherData fetchWeather(_i4.WeatherDataRequest? weatherDataRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWeather,
          [weatherDataRequest],
        ),
        returnValue: _FakeWeatherData_0(
          this,
          Invocation.method(
            #fetchWeather,
            [weatherDataRequest],
          ),
        ),
        returnValueForMissingStub: _FakeWeatherData_0(
          this,
          Invocation.method(
            #fetchWeather,
            [weatherDataRequest],
          ),
        ),
      ) as _i2.WeatherData);
}
