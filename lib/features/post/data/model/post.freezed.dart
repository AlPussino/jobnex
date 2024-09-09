// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get post_title => throw _privateConstructorUsedError;
  set post_title(String value) => throw _privateConstructorUsedError;
  String get post_body => throw _privateConstructorUsedError;
  set post_body(String value) => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  set image(String value) => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  set created_at(DateTime value) => throw _privateConstructorUsedError;
  String get post_owner_id => throw _privateConstructorUsedError;
  set post_owner_id(String value) => throw _privateConstructorUsedError;
  List<React> get reacts => throw _privateConstructorUsedError;
  set reacts(List<React> value) => throw _privateConstructorUsedError;
  List<Comment> get comments => throw _privateConstructorUsedError;
  set comments(List<Comment> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String id,
      String post_title,
      String post_body,
      String image,
      DateTime created_at,
      String post_owner_id,
      List<React> reacts,
      List<Comment> comments});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? post_title = null,
    Object? post_body = null,
    Object? image = null,
    Object? created_at = null,
    Object? post_owner_id = null,
    Object? reacts = null,
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      post_title: null == post_title
          ? _value.post_title
          : post_title // ignore: cast_nullable_to_non_nullable
              as String,
      post_body: null == post_body
          ? _value.post_body
          : post_body // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      post_owner_id: null == post_owner_id
          ? _value.post_owner_id
          : post_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      reacts: null == reacts
          ? _value.reacts
          : reacts // ignore: cast_nullable_to_non_nullable
              as List<React>,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String post_title,
      String post_body,
      String image,
      DateTime created_at,
      String post_owner_id,
      List<React> reacts,
      List<Comment> comments});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? post_title = null,
    Object? post_body = null,
    Object? image = null,
    Object? created_at = null,
    Object? post_owner_id = null,
    Object? reacts = null,
    Object? comments = null,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      post_title: null == post_title
          ? _value.post_title
          : post_title // ignore: cast_nullable_to_non_nullable
              as String,
      post_body: null == post_body
          ? _value.post_body
          : post_body // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      post_owner_id: null == post_owner_id
          ? _value.post_owner_id
          : post_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      reacts: null == reacts
          ? _value.reacts
          : reacts // ignore: cast_nullable_to_non_nullable
              as List<React>,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl extends _Post {
  _$PostImpl(
      {required this.id,
      required this.post_title,
      required this.post_body,
      required this.image,
      required this.created_at,
      required this.post_owner_id,
      required this.reacts,
      required this.comments})
      : super._();

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  String id;
  @override
  String post_title;
  @override
  String post_body;
  @override
  String image;
  @override
  DateTime created_at;
  @override
  String post_owner_id;
  @override
  List<React> reacts;
  @override
  List<Comment> comments;

  @override
  String toString() {
    return 'Post(id: $id, post_title: $post_title, post_body: $post_body, image: $image, created_at: $created_at, post_owner_id: $post_owner_id, reacts: $reacts, comments: $comments)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post extends Post {
  factory _Post(
      {required String id,
      required String post_title,
      required String post_body,
      required String image,
      required DateTime created_at,
      required String post_owner_id,
      required List<React> reacts,
      required List<Comment> comments}) = _$PostImpl;
  _Post._() : super._();

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get post_title;
  set post_title(String value);
  @override
  String get post_body;
  set post_body(String value);
  @override
  String get image;
  set image(String value);
  @override
  DateTime get created_at;
  set created_at(DateTime value);
  @override
  String get post_owner_id;
  set post_owner_id(String value);
  @override
  List<React> get reacts;
  set reacts(List<React> value);
  @override
  List<Comment> get comments;
  set comments(List<Comment> value);
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
