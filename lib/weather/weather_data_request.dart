import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_data_request.freezed.dart';
part 'weather_data_request.g.dart';

@freezed
class WeatherDataRequest with _$WeatherDataRequest {
  const factory WeatherDataRequest({
    required String area,
    required DateTime date,
  }) = _WeatherDataRequest;

  factory WeatherDataRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataRequestFromJson(json);
}
