// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_call.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoCall _$VideoCallFromJson(Map<String, dynamic> json) {
  return _VideoCall.fromJson(json);
}

/// @nodoc
mixin _$VideoCall {
  String get caller_id => throw _privateConstructorUsedError;
  set caller_id(String value) => throw _privateConstructorUsedError;
  String get receiver_id => throw _privateConstructorUsedError;
  set receiver_id(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoCallCopyWith<VideoCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCallCopyWith<$Res> {
  factory $VideoCallCopyWith(VideoCall value, $Res Function(VideoCall) then) =
      _$VideoCallCopyWithImpl<$Res, VideoCall>;
  @useResult
  $Res call({String caller_id, String receiver_id});
}

/// @nodoc
class _$VideoCallCopyWithImpl<$Res, $Val extends VideoCall>
    implements $VideoCallCopyWith<$Res> {
  _$VideoCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caller_id = null,
    Object? receiver_id = null,
  }) {
    return _then(_value.copyWith(
      caller_id: null == caller_id
          ? _value.caller_id
          : caller_id // ignore: cast_nullable_to_non_nullable
              as String,
      receiver_id: null == receiver_id
          ? _value.receiver_id
          : receiver_id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoCallImplCopyWith<$Res>
    implements $VideoCallCopyWith<$Res> {
  factory _$$VideoCallImplCopyWith(
          _$VideoCallImpl value, $Res Function(_$VideoCallImpl) then) =
      __$$VideoCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String caller_id, String receiver_id});
}

/// @nodoc
class __$$VideoCallImplCopyWithImpl<$Res>
    extends _$VideoCallCopyWithImpl<$Res, _$VideoCallImpl>
    implements _$$VideoCallImplCopyWith<$Res> {
  __$$VideoCallImplCopyWithImpl(
      _$VideoCallImpl _value, $Res Function(_$VideoCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caller_id = null,
    Object? receiver_id = null,
  }) {
    return _then(_$VideoCallImpl(
      caller_id: null == caller_id
          ? _value.caller_id
          : caller_id // ignore: cast_nullable_to_non_nullable
              as String,
      receiver_id: null == receiver_id
          ? _value.receiver_id
          : receiver_id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoCallImpl extends _VideoCall {
  _$VideoCallImpl({required this.caller_id, required this.receiver_id})
      : super._();

  factory _$VideoCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoCallImplFromJson(json);

  @override
  String caller_id;
  @override
  String receiver_id;

  @override
  String toString() {
    return 'VideoCall(caller_id: $caller_id, receiver_id: $receiver_id)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoCallImplCopyWith<_$VideoCallImpl> get copyWith =>
      __$$VideoCallImplCopyWithImpl<_$VideoCallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoCallImplToJson(
      this,
    );
  }
}

abstract class _VideoCall extends VideoCall {
  factory _VideoCall({required String caller_id, required String receiver_id}) =
      _$VideoCallImpl;
  _VideoCall._() : super._();

  factory _VideoCall.fromJson(Map<String, dynamic> json) =
      _$VideoCallImpl.fromJson;

  @override
  String get caller_id;
  set caller_id(String value);
  @override
  String get receiver_id;
  set receiver_id(String value);
  @override
  @JsonKey(ignore: true)
  _$$VideoCallImplCopyWith<_$VideoCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
