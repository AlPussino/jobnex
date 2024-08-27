// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_experience.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) {
  return _WorkExperience.fromJson(json);
}

/// @nodoc
mixin _$WorkExperience {
  String get job_experience_id => throw _privateConstructorUsedError;
  String get job_position => throw _privateConstructorUsedError;
  String get job_location => throw _privateConstructorUsedError;
  String get company_name => throw _privateConstructorUsedError;
  DateTime get start_date => throw _privateConstructorUsedError;
  DateTime get stop_date => throw _privateConstructorUsedError;
  bool get still_working => throw _privateConstructorUsedError;
  String get job_type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkExperienceCopyWith<WorkExperience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkExperienceCopyWith<$Res> {
  factory $WorkExperienceCopyWith(
          WorkExperience value, $Res Function(WorkExperience) then) =
      _$WorkExperienceCopyWithImpl<$Res, WorkExperience>;
  @useResult
  $Res call(
      {String job_experience_id,
      String job_position,
      String job_location,
      String company_name,
      DateTime start_date,
      DateTime stop_date,
      bool still_working,
      String job_type});
}

/// @nodoc
class _$WorkExperienceCopyWithImpl<$Res, $Val extends WorkExperience>
    implements $WorkExperienceCopyWith<$Res> {
  _$WorkExperienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job_experience_id = null,
    Object? job_position = null,
    Object? job_location = null,
    Object? company_name = null,
    Object? start_date = null,
    Object? stop_date = null,
    Object? still_working = null,
    Object? job_type = null,
  }) {
    return _then(_value.copyWith(
      job_experience_id: null == job_experience_id
          ? _value.job_experience_id
          : job_experience_id // ignore: cast_nullable_to_non_nullable
              as String,
      job_position: null == job_position
          ? _value.job_position
          : job_position // ignore: cast_nullable_to_non_nullable
              as String,
      job_location: null == job_location
          ? _value.job_location
          : job_location // ignore: cast_nullable_to_non_nullable
              as String,
      company_name: null == company_name
          ? _value.company_name
          : company_name // ignore: cast_nullable_to_non_nullable
              as String,
      start_date: null == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stop_date: null == stop_date
          ? _value.stop_date
          : stop_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      still_working: null == still_working
          ? _value.still_working
          : still_working // ignore: cast_nullable_to_non_nullable
              as bool,
      job_type: null == job_type
          ? _value.job_type
          : job_type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkExperienceImplCopyWith<$Res>
    implements $WorkExperienceCopyWith<$Res> {
  factory _$$WorkExperienceImplCopyWith(_$WorkExperienceImpl value,
          $Res Function(_$WorkExperienceImpl) then) =
      __$$WorkExperienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String job_experience_id,
      String job_position,
      String job_location,
      String company_name,
      DateTime start_date,
      DateTime stop_date,
      bool still_working,
      String job_type});
}

/// @nodoc
class __$$WorkExperienceImplCopyWithImpl<$Res>
    extends _$WorkExperienceCopyWithImpl<$Res, _$WorkExperienceImpl>
    implements _$$WorkExperienceImplCopyWith<$Res> {
  __$$WorkExperienceImplCopyWithImpl(
      _$WorkExperienceImpl _value, $Res Function(_$WorkExperienceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job_experience_id = null,
    Object? job_position = null,
    Object? job_location = null,
    Object? company_name = null,
    Object? start_date = null,
    Object? stop_date = null,
    Object? still_working = null,
    Object? job_type = null,
  }) {
    return _then(_$WorkExperienceImpl(
      job_experience_id: null == job_experience_id
          ? _value.job_experience_id
          : job_experience_id // ignore: cast_nullable_to_non_nullable
              as String,
      job_position: null == job_position
          ? _value.job_position
          : job_position // ignore: cast_nullable_to_non_nullable
              as String,
      job_location: null == job_location
          ? _value.job_location
          : job_location // ignore: cast_nullable_to_non_nullable
              as String,
      company_name: null == company_name
          ? _value.company_name
          : company_name // ignore: cast_nullable_to_non_nullable
              as String,
      start_date: null == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stop_date: null == stop_date
          ? _value.stop_date
          : stop_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      still_working: null == still_working
          ? _value.still_working
          : still_working // ignore: cast_nullable_to_non_nullable
              as bool,
      job_type: null == job_type
          ? _value.job_type
          : job_type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkExperienceImpl extends _WorkExperience {
  const _$WorkExperienceImpl(
      {required this.job_experience_id,
      required this.job_position,
      required this.job_location,
      required this.company_name,
      required this.start_date,
      required this.stop_date,
      required this.still_working,
      required this.job_type})
      : super._();

  factory _$WorkExperienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkExperienceImplFromJson(json);

  @override
  final String job_experience_id;
  @override
  final String job_position;
  @override
  final String job_location;
  @override
  final String company_name;
  @override
  final DateTime start_date;
  @override
  final DateTime stop_date;
  @override
  final bool still_working;
  @override
  final String job_type;

  @override
  String toString() {
    return 'WorkExperience(job_experience_id: $job_experience_id, job_position: $job_position, job_location: $job_location, company_name: $company_name, start_date: $start_date, stop_date: $stop_date, still_working: $still_working, job_type: $job_type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkExperienceImpl &&
            (identical(other.job_experience_id, job_experience_id) ||
                other.job_experience_id == job_experience_id) &&
            (identical(other.job_position, job_position) ||
                other.job_position == job_position) &&
            (identical(other.job_location, job_location) ||
                other.job_location == job_location) &&
            (identical(other.company_name, company_name) ||
                other.company_name == company_name) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.stop_date, stop_date) ||
                other.stop_date == stop_date) &&
            (identical(other.still_working, still_working) ||
                other.still_working == still_working) &&
            (identical(other.job_type, job_type) ||
                other.job_type == job_type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      job_experience_id,
      job_position,
      job_location,
      company_name,
      start_date,
      stop_date,
      still_working,
      job_type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkExperienceImplCopyWith<_$WorkExperienceImpl> get copyWith =>
      __$$WorkExperienceImplCopyWithImpl<_$WorkExperienceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkExperienceImplToJson(
      this,
    );
  }
}

abstract class _WorkExperience extends WorkExperience {
  const factory _WorkExperience(
      {required final String job_experience_id,
      required final String job_position,
      required final String job_location,
      required final String company_name,
      required final DateTime start_date,
      required final DateTime stop_date,
      required final bool still_working,
      required final String job_type}) = _$WorkExperienceImpl;
  const _WorkExperience._() : super._();

  factory _WorkExperience.fromJson(Map<String, dynamic> json) =
      _$WorkExperienceImpl.fromJson;

  @override
  String get job_experience_id;
  @override
  String get job_position;
  @override
  String get job_location;
  @override
  String get company_name;
  @override
  DateTime get start_date;
  @override
  DateTime get stop_date;
  @override
  bool get still_working;
  @override
  String get job_type;
  @override
  @JsonKey(ignore: true)
  _$$WorkExperienceImplCopyWith<_$WorkExperienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
