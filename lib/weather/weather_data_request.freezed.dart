// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_data_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherDataRequest _$WeatherDataRequestFromJson(Map<String, dynamic> json) {
  return _WeatherDataRequest.fromJson(json);
}

/// @nodoc
mixin _$WeatherDataRequest {
  String get area => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherDataRequestCopyWith<WeatherDataRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherDataRequestCopyWith<$Res> {
  factory $WeatherDataRequestCopyWith(
          WeatherDataRequest value, $Res Function(WeatherDataRequest) then) =
      _$WeatherDataRequestCopyWithImpl<$Res, WeatherDataRequest>;
  @useResult
  $Res call({String area, DateTime date});
}

/// @nodoc
class _$WeatherDataRequestCopyWithImpl<$Res, $Val extends WeatherDataRequest>
    implements $WeatherDataRequestCopyWith<$Res> {
  _$WeatherDataRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherDataRequestImplCopyWith<$Res>
    implements $WeatherDataRequestCopyWith<$Res> {
  factory _$$WeatherDataRequestImplCopyWith(_$WeatherDataRequestImpl value,
          $Res Function(_$WeatherDataRequestImpl) then) =
      __$$WeatherDataRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String area, DateTime date});
}

/// @nodoc
class __$$WeatherDataRequestImplCopyWithImpl<$Res>
    extends _$WeatherDataRequestCopyWithImpl<$Res, _$WeatherDataRequestImpl>
    implements _$$WeatherDataRequestImplCopyWith<$Res> {
  __$$WeatherDataRequestImplCopyWithImpl(_$WeatherDataRequestImpl _value,
      $Res Function(_$WeatherDataRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? date = null,
  }) {
    return _then(_$WeatherDataRequestImpl(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherDataRequestImpl implements _WeatherDataRequest {
  const _$WeatherDataRequestImpl({required this.area, required this.date});

  factory _$WeatherDataRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherDataRequestImplFromJson(json);

  @override
  final String area;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'WeatherDataRequest(area: $area, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherDataRequestImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherDataRequestImplCopyWith<_$WeatherDataRequestImpl> get copyWith =>
      __$$WeatherDataRequestImplCopyWithImpl<_$WeatherDataRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherDataRequestImplToJson(
      this,
    );
  }
}

abstract class _WeatherDataRequest implements WeatherDataRequest {
  const factory _WeatherDataRequest(
      {required final String area,
      required final DateTime date}) = _$WeatherDataRequestImpl;

  factory _WeatherDataRequest.fromJson(Map<String, dynamic> json) =
      _$WeatherDataRequestImpl.fromJson;

  @override
  String get area;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$WeatherDataRequestImplCopyWith<_$WeatherDataRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
