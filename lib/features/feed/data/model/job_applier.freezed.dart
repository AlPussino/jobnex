// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_applier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JobApplier _$JobApplierFromJson(Map<String, dynamic> json) {
  return _JobApplier.fromJson(json);
}

/// @nodoc
mixin _$JobApplier {
  String get applier_id => throw _privateConstructorUsedError;
  String get applier_name => throw _privateConstructorUsedError;
  String get applier_profile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobApplierCopyWith<JobApplier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobApplierCopyWith<$Res> {
  factory $JobApplierCopyWith(
          JobApplier value, $Res Function(JobApplier) then) =
      _$JobApplierCopyWithImpl<$Res, JobApplier>;
  @useResult
  $Res call({String applier_id, String applier_name, String applier_profile});
}

/// @nodoc
class _$JobApplierCopyWithImpl<$Res, $Val extends JobApplier>
    implements $JobApplierCopyWith<$Res> {
  _$JobApplierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applier_id = null,
    Object? applier_name = null,
    Object? applier_profile = null,
  }) {
    return _then(_value.copyWith(
      applier_id: null == applier_id
          ? _value.applier_id
          : applier_id // ignore: cast_nullable_to_non_nullable
              as String,
      applier_name: null == applier_name
          ? _value.applier_name
          : applier_name // ignore: cast_nullable_to_non_nullable
              as String,
      applier_profile: null == applier_profile
          ? _value.applier_profile
          : applier_profile // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobApplierImplCopyWith<$Res>
    implements $JobApplierCopyWith<$Res> {
  factory _$$JobApplierImplCopyWith(
          _$JobApplierImpl value, $Res Function(_$JobApplierImpl) then) =
      __$$JobApplierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String applier_id, String applier_name, String applier_profile});
}

/// @nodoc
class __$$JobApplierImplCopyWithImpl<$Res>
    extends _$JobApplierCopyWithImpl<$Res, _$JobApplierImpl>
    implements _$$JobApplierImplCopyWith<$Res> {
  __$$JobApplierImplCopyWithImpl(
      _$JobApplierImpl _value, $Res Function(_$JobApplierImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applier_id = null,
    Object? applier_name = null,
    Object? applier_profile = null,
  }) {
    return _then(_$JobApplierImpl(
      applier_id: null == applier_id
          ? _value.applier_id
          : applier_id // ignore: cast_nullable_to_non_nullable
              as String,
      applier_name: null == applier_name
          ? _value.applier_name
          : applier_name // ignore: cast_nullable_to_non_nullable
              as String,
      applier_profile: null == applier_profile
          ? _value.applier_profile
          : applier_profile // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobApplierImpl extends _JobApplier {
  const _$JobApplierImpl(
      {required this.applier_id,
      required this.applier_name,
      required this.applier_profile})
      : super._();

  factory _$JobApplierImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobApplierImplFromJson(json);

  @override
  final String applier_id;
  @override
  final String applier_name;
  @override
  final String applier_profile;

  @override
  String toString() {
    return 'JobApplier(applier_id: $applier_id, applier_name: $applier_name, applier_profile: $applier_profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobApplierImpl &&
            (identical(other.applier_id, applier_id) ||
                other.applier_id == applier_id) &&
            (identical(other.applier_name, applier_name) ||
                other.applier_name == applier_name) &&
            (identical(other.applier_profile, applier_profile) ||
                other.applier_profile == applier_profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, applier_id, applier_name, applier_profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JobApplierImplCopyWith<_$JobApplierImpl> get copyWith =>
      __$$JobApplierImplCopyWithImpl<_$JobApplierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobApplierImplToJson(
      this,
    );
  }
}

abstract class _JobApplier extends JobApplier {
  const factory _JobApplier(
      {required final String applier_id,
      required final String applier_name,
      required final String applier_profile}) = _$JobApplierImpl;
  const _JobApplier._() : super._();

  factory _JobApplier.fromJson(Map<String, dynamic> json) =
      _$JobApplierImpl.fromJson;

  @override
  String get applier_id;
  @override
  String get applier_name;
  @override
  String get applier_profile;
  @override
  @JsonKey(ignore: true)
  _$$JobApplierImplCopyWith<_$JobApplierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
