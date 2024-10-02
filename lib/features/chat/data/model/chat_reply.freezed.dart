// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatReply _$ChatReplyFromJson(Map<String, dynamic> json) {
  return _ChatReply.fromJson(json);
}

/// @nodoc
mixin _$ChatReply {
  String get message => throw _privateConstructorUsedError;
  set message(String value) => throw _privateConstructorUsedError;
  String get message_type => throw _privateConstructorUsedError;
  set message_type(String value) => throw _privateConstructorUsedError;
  String get message_owner_id => throw _privateConstructorUsedError;
  set message_owner_id(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatReplyCopyWith<ChatReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReplyCopyWith<$Res> {
  factory $ChatReplyCopyWith(ChatReply value, $Res Function(ChatReply) then) =
      _$ChatReplyCopyWithImpl<$Res, ChatReply>;
  @useResult
  $Res call({String message, String message_type, String message_owner_id});
}

/// @nodoc
class _$ChatReplyCopyWithImpl<$Res, $Val extends ChatReply>
    implements $ChatReplyCopyWith<$Res> {
  _$ChatReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? message_type = null,
    Object? message_owner_id = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      message_type: null == message_type
          ? _value.message_type
          : message_type // ignore: cast_nullable_to_non_nullable
              as String,
      message_owner_id: null == message_owner_id
          ? _value.message_owner_id
          : message_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatReplyImplCopyWith<$Res>
    implements $ChatReplyCopyWith<$Res> {
  factory _$$ChatReplyImplCopyWith(
          _$ChatReplyImpl value, $Res Function(_$ChatReplyImpl) then) =
      __$$ChatReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String message_type, String message_owner_id});
}

/// @nodoc
class __$$ChatReplyImplCopyWithImpl<$Res>
    extends _$ChatReplyCopyWithImpl<$Res, _$ChatReplyImpl>
    implements _$$ChatReplyImplCopyWith<$Res> {
  __$$ChatReplyImplCopyWithImpl(
      _$ChatReplyImpl _value, $Res Function(_$ChatReplyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? message_type = null,
    Object? message_owner_id = null,
  }) {
    return _then(_$ChatReplyImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      message_type: null == message_type
          ? _value.message_type
          : message_type // ignore: cast_nullable_to_non_nullable
              as String,
      message_owner_id: null == message_owner_id
          ? _value.message_owner_id
          : message_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatReplyImpl extends _ChatReply {
  _$ChatReplyImpl(
      {required this.message,
      required this.message_type,
      required this.message_owner_id})
      : super._();

  factory _$ChatReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatReplyImplFromJson(json);

  @override
  String message;
  @override
  String message_type;
  @override
  String message_owner_id;

  @override
  String toString() {
    return 'ChatReply(message: $message, message_type: $message_type, message_owner_id: $message_owner_id)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReplyImplCopyWith<_$ChatReplyImpl> get copyWith =>
      __$$ChatReplyImplCopyWithImpl<_$ChatReplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatReplyImplToJson(
      this,
    );
  }
}

abstract class _ChatReply extends ChatReply {
  factory _ChatReply(
      {required String message,
      required String message_type,
      required String message_owner_id}) = _$ChatReplyImpl;
  _ChatReply._() : super._();

  factory _ChatReply.fromJson(Map<String, dynamic> json) =
      _$ChatReplyImpl.fromJson;

  @override
  String get message;
  set message(String value);
  @override
  String get message_type;
  set message_type(String value);
  @override
  String get message_owner_id;
  set message_owner_id(String value);
  @override
  @JsonKey(ignore: true)
  _$$ChatReplyImplCopyWith<_$ChatReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
