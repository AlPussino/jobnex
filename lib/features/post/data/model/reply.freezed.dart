// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return _Reply.fromJson(json);
}

/// @nodoc
mixin _$Reply {
  String get reply_id => throw _privateConstructorUsedError;
  set reply_id(String value) => throw _privateConstructorUsedError;
  String get reply_owner_id => throw _privateConstructorUsedError;
  set reply_owner_id(String value) => throw _privateConstructorUsedError;
  String get reply => throw _privateConstructorUsedError;
  set reply(String value) => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  set created_at(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyCopyWith<Reply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyCopyWith<$Res> {
  factory $ReplyCopyWith(Reply value, $Res Function(Reply) then) =
      _$ReplyCopyWithImpl<$Res, Reply>;
  @useResult
  $Res call(
      {String reply_id,
      String reply_owner_id,
      String reply,
      DateTime created_at});
}

/// @nodoc
class _$ReplyCopyWithImpl<$Res, $Val extends Reply>
    implements $ReplyCopyWith<$Res> {
  _$ReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reply_id = null,
    Object? reply_owner_id = null,
    Object? reply = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      reply_id: null == reply_id
          ? _value.reply_id
          : reply_id // ignore: cast_nullable_to_non_nullable
              as String,
      reply_owner_id: null == reply_owner_id
          ? _value.reply_owner_id
          : reply_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReplyImplCopyWith<$Res> implements $ReplyCopyWith<$Res> {
  factory _$$ReplyImplCopyWith(
          _$ReplyImpl value, $Res Function(_$ReplyImpl) then) =
      __$$ReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String reply_id,
      String reply_owner_id,
      String reply,
      DateTime created_at});
}

/// @nodoc
class __$$ReplyImplCopyWithImpl<$Res>
    extends _$ReplyCopyWithImpl<$Res, _$ReplyImpl>
    implements _$$ReplyImplCopyWith<$Res> {
  __$$ReplyImplCopyWithImpl(
      _$ReplyImpl _value, $Res Function(_$ReplyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reply_id = null,
    Object? reply_owner_id = null,
    Object? reply = null,
    Object? created_at = null,
  }) {
    return _then(_$ReplyImpl(
      reply_id: null == reply_id
          ? _value.reply_id
          : reply_id // ignore: cast_nullable_to_non_nullable
              as String,
      reply_owner_id: null == reply_owner_id
          ? _value.reply_owner_id
          : reply_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplyImpl extends _Reply {
  _$ReplyImpl(
      {required this.reply_id,
      required this.reply_owner_id,
      required this.reply,
      required this.created_at})
      : super._();

  factory _$ReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplyImplFromJson(json);

  @override
  String reply_id;
  @override
  String reply_owner_id;
  @override
  String reply;
  @override
  DateTime created_at;

  @override
  String toString() {
    return 'Reply(reply_id: $reply_id, reply_owner_id: $reply_owner_id, reply: $reply, created_at: $created_at)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyImplCopyWith<_$ReplyImpl> get copyWith =>
      __$$ReplyImplCopyWithImpl<_$ReplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplyImplToJson(
      this,
    );
  }
}

abstract class _Reply extends Reply {
  factory _Reply(
      {required String reply_id,
      required String reply_owner_id,
      required String reply,
      required DateTime created_at}) = _$ReplyImpl;
  _Reply._() : super._();

  factory _Reply.fromJson(Map<String, dynamic> json) = _$ReplyImpl.fromJson;

  @override
  String get reply_id;
  set reply_id(String value);
  @override
  String get reply_owner_id;
  set reply_owner_id(String value);
  @override
  String get reply;
  set reply(String value);
  @override
  DateTime get created_at;
  set created_at(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$ReplyImplCopyWith<_$ReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
