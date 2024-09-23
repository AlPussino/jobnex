// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryBody _$StoryBodyFromJson(Map<String, dynamic> json) {
  return _StoryBody.fromJson(json);
}

/// @nodoc
mixin _$StoryBody {
  String get image => throw _privateConstructorUsedError;
  set image(String value) => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  set created_at(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryBodyCopyWith<StoryBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryBodyCopyWith<$Res> {
  factory $StoryBodyCopyWith(StoryBody value, $Res Function(StoryBody) then) =
      _$StoryBodyCopyWithImpl<$Res, StoryBody>;
  @useResult
  $Res call({String image, DateTime created_at});
}

/// @nodoc
class _$StoryBodyCopyWithImpl<$Res, $Val extends StoryBody>
    implements $StoryBodyCopyWith<$Res> {
  _$StoryBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryBodyImplCopyWith<$Res>
    implements $StoryBodyCopyWith<$Res> {
  factory _$$StoryBodyImplCopyWith(
          _$StoryBodyImpl value, $Res Function(_$StoryBodyImpl) then) =
      __$$StoryBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String image, DateTime created_at});
}

/// @nodoc
class __$$StoryBodyImplCopyWithImpl<$Res>
    extends _$StoryBodyCopyWithImpl<$Res, _$StoryBodyImpl>
    implements _$$StoryBodyImplCopyWith<$Res> {
  __$$StoryBodyImplCopyWithImpl(
      _$StoryBodyImpl _value, $Res Function(_$StoryBodyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? created_at = null,
  }) {
    return _then(_$StoryBodyImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
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
class _$StoryBodyImpl extends _StoryBody {
  _$StoryBodyImpl({required this.image, required this.created_at}) : super._();

  factory _$StoryBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryBodyImplFromJson(json);

  @override
  String image;
  @override
  DateTime created_at;

  @override
  String toString() {
    return 'StoryBody(image: $image, created_at: $created_at)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryBodyImplCopyWith<_$StoryBodyImpl> get copyWith =>
      __$$StoryBodyImplCopyWithImpl<_$StoryBodyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryBodyImplToJson(
      this,
    );
  }
}

abstract class _StoryBody extends StoryBody {
  factory _StoryBody({required String image, required DateTime created_at}) =
      _$StoryBodyImpl;
  _StoryBody._() : super._();

  factory _StoryBody.fromJson(Map<String, dynamic> json) =
      _$StoryBodyImpl.fromJson;

  @override
  String get image;
  set image(String value);
  @override
  DateTime get created_at;
  set created_at(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$StoryBodyImplCopyWith<_$StoryBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
