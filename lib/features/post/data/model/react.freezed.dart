// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'react.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

React _$ReactFromJson(Map<String, dynamic> json) {
  return _React.fromJson(json);
}

/// @nodoc
mixin _$React {
  String get react_owner_id => throw _privateConstructorUsedError;
  set react_owner_id(String value) => throw _privateConstructorUsedError;
  String get react => throw _privateConstructorUsedError;
  set react(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReactCopyWith<React> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactCopyWith<$Res> {
  factory $ReactCopyWith(React value, $Res Function(React) then) =
      _$ReactCopyWithImpl<$Res, React>;
  @useResult
  $Res call({String react_owner_id, String react});
}

/// @nodoc
class _$ReactCopyWithImpl<$Res, $Val extends React>
    implements $ReactCopyWith<$Res> {
  _$ReactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? react_owner_id = null,
    Object? react = null,
  }) {
    return _then(_value.copyWith(
      react_owner_id: null == react_owner_id
          ? _value.react_owner_id
          : react_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      react: null == react
          ? _value.react
          : react // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReactImplCopyWith<$Res> implements $ReactCopyWith<$Res> {
  factory _$$ReactImplCopyWith(
          _$ReactImpl value, $Res Function(_$ReactImpl) then) =
      __$$ReactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String react_owner_id, String react});
}

/// @nodoc
class __$$ReactImplCopyWithImpl<$Res>
    extends _$ReactCopyWithImpl<$Res, _$ReactImpl>
    implements _$$ReactImplCopyWith<$Res> {
  __$$ReactImplCopyWithImpl(
      _$ReactImpl _value, $Res Function(_$ReactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? react_owner_id = null,
    Object? react = null,
  }) {
    return _then(_$ReactImpl(
      react_owner_id: null == react_owner_id
          ? _value.react_owner_id
          : react_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      react: null == react
          ? _value.react
          : react // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReactImpl extends _React {
  _$ReactImpl({required this.react_owner_id, required this.react}) : super._();

  factory _$ReactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReactImplFromJson(json);

  @override
  String react_owner_id;
  @override
  String react;

  @override
  String toString() {
    return 'React(react_owner_id: $react_owner_id, react: $react)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactImplCopyWith<_$ReactImpl> get copyWith =>
      __$$ReactImplCopyWithImpl<_$ReactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReactImplToJson(
      this,
    );
  }
}

abstract class _React extends React {
  factory _React({required String react_owner_id, required String react}) =
      _$ReactImpl;
  _React._() : super._();

  factory _React.fromJson(Map<String, dynamic> json) = _$ReactImpl.fromJson;

  @override
  String get react_owner_id;
  set react_owner_id(String value);
  @override
  String get react;
  set react(String value);
  @override
  @JsonKey(ignore: true)
  _$$ReactImplCopyWith<_$ReactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
