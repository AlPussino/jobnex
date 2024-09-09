// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get comment_id => throw _privateConstructorUsedError;
  set comment_id(String value) => throw _privateConstructorUsedError;
  String get comment_owner_id => throw _privateConstructorUsedError;
  set comment_owner_id(String value) => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  set comment(String value) => throw _privateConstructorUsedError;
  List<Reply> get replies => throw _privateConstructorUsedError;
  set replies(List<Reply> value) => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  set created_at(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {String comment_id,
      String comment_owner_id,
      String comment,
      List<Reply> replies,
      DateTime created_at});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment_id = null,
    Object? comment_owner_id = null,
    Object? comment = null,
    Object? replies = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      comment_id: null == comment_id
          ? _value.comment_id
          : comment_id // ignore: cast_nullable_to_non_nullable
              as String,
      comment_owner_id: null == comment_owner_id
          ? _value.comment_owner_id
          : comment_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String comment_id,
      String comment_owner_id,
      String comment,
      List<Reply> replies,
      DateTime created_at});
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment_id = null,
    Object? comment_owner_id = null,
    Object? comment = null,
    Object? replies = null,
    Object? created_at = null,
  }) {
    return _then(_$CommentImpl(
      comment_id: null == comment_id
          ? _value.comment_id
          : comment_id // ignore: cast_nullable_to_non_nullable
              as String,
      comment_owner_id: null == comment_owner_id
          ? _value.comment_owner_id
          : comment_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl extends _Comment {
  _$CommentImpl(
      {required this.comment_id,
      required this.comment_owner_id,
      required this.comment,
      required this.replies,
      required this.created_at})
      : super._();

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  String comment_id;
  @override
  String comment_owner_id;
  @override
  String comment;
  @override
  List<Reply> replies;
  @override
  DateTime created_at;

  @override
  String toString() {
    return 'Comment(comment_id: $comment_id, comment_owner_id: $comment_owner_id, comment: $comment, replies: $replies, created_at: $created_at)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment extends Comment {
  factory _Comment(
      {required String comment_id,
      required String comment_owner_id,
      required String comment,
      required List<Reply> replies,
      required DateTime created_at}) = _$CommentImpl;
  _Comment._() : super._();

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  String get comment_id;
  set comment_id(String value);
  @override
  String get comment_owner_id;
  set comment_owner_id(String value);
  @override
  String get comment;
  set comment(String value);
  @override
  List<Reply> get replies;
  set replies(List<Reply> value);
  @override
  DateTime get created_at;
  set created_at(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
