// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get user_id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get mobile_number => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  DateTime get birth_date => throw _privateConstructorUsedError;
  String get professional_title => throw _privateConstructorUsedError;
  String get nationality => throw _privateConstructorUsedError;
  List<String> get skill => throw _privateConstructorUsedError;
  String get fcm_token => throw _privateConstructorUsedError;
  bool get is_online => throw _privateConstructorUsedError;
  DateTime get last_online => throw _privateConstructorUsedError;
  bool get in_chat => throw _privateConstructorUsedError;
  String get profile_url => throw _privateConstructorUsedError;
  String get cover_url => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String user_id,
      String name,
      String email,
      String mobile_number,
      String gender,
      DateTime birth_date,
      String professional_title,
      String nationality,
      List<String> skill,
      String fcm_token,
      bool is_online,
      DateTime last_online,
      bool in_chat,
      String profile_url,
      String cover_url,
      double latitude,
      double longitude,
      String address});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = null,
    Object? name = null,
    Object? email = null,
    Object? mobile_number = null,
    Object? gender = null,
    Object? birth_date = null,
    Object? professional_title = null,
    Object? nationality = null,
    Object? skill = null,
    Object? fcm_token = null,
    Object? is_online = null,
    Object? last_online = null,
    Object? in_chat = null,
    Object? profile_url = null,
    Object? cover_url = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      mobile_number: null == mobile_number
          ? _value.mobile_number
          : mobile_number // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      birth_date: null == birth_date
          ? _value.birth_date
          : birth_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      professional_title: null == professional_title
          ? _value.professional_title
          : professional_title // ignore: cast_nullable_to_non_nullable
              as String,
      nationality: null == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String,
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fcm_token: null == fcm_token
          ? _value.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String,
      is_online: null == is_online
          ? _value.is_online
          : is_online // ignore: cast_nullable_to_non_nullable
              as bool,
      last_online: null == last_online
          ? _value.last_online
          : last_online // ignore: cast_nullable_to_non_nullable
              as DateTime,
      in_chat: null == in_chat
          ? _value.in_chat
          : in_chat // ignore: cast_nullable_to_non_nullable
              as bool,
      profile_url: null == profile_url
          ? _value.profile_url
          : profile_url // ignore: cast_nullable_to_non_nullable
              as String,
      cover_url: null == cover_url
          ? _value.cover_url
          : cover_url // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String user_id,
      String name,
      String email,
      String mobile_number,
      String gender,
      DateTime birth_date,
      String professional_title,
      String nationality,
      List<String> skill,
      String fcm_token,
      bool is_online,
      DateTime last_online,
      bool in_chat,
      String profile_url,
      String cover_url,
      double latitude,
      double longitude,
      String address});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = null,
    Object? name = null,
    Object? email = null,
    Object? mobile_number = null,
    Object? gender = null,
    Object? birth_date = null,
    Object? professional_title = null,
    Object? nationality = null,
    Object? skill = null,
    Object? fcm_token = null,
    Object? is_online = null,
    Object? last_online = null,
    Object? in_chat = null,
    Object? profile_url = null,
    Object? cover_url = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
  }) {
    return _then(_$UserModelImpl(
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      mobile_number: null == mobile_number
          ? _value.mobile_number
          : mobile_number // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      birth_date: null == birth_date
          ? _value.birth_date
          : birth_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      professional_title: null == professional_title
          ? _value.professional_title
          : professional_title // ignore: cast_nullable_to_non_nullable
              as String,
      nationality: null == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String,
      skill: null == skill
          ? _value._skill
          : skill // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fcm_token: null == fcm_token
          ? _value.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String,
      is_online: null == is_online
          ? _value.is_online
          : is_online // ignore: cast_nullable_to_non_nullable
              as bool,
      last_online: null == last_online
          ? _value.last_online
          : last_online // ignore: cast_nullable_to_non_nullable
              as DateTime,
      in_chat: null == in_chat
          ? _value.in_chat
          : in_chat // ignore: cast_nullable_to_non_nullable
              as bool,
      profile_url: null == profile_url
          ? _value.profile_url
          : profile_url // ignore: cast_nullable_to_non_nullable
              as String,
      cover_url: null == cover_url
          ? _value.cover_url
          : cover_url // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {required this.user_id,
      required this.name,
      required this.email,
      required this.mobile_number,
      required this.gender,
      required this.birth_date,
      required this.professional_title,
      required this.nationality,
      required final List<String> skill,
      required this.fcm_token,
      required this.is_online,
      required this.last_online,
      required this.in_chat,
      required this.profile_url,
      required this.cover_url,
      required this.latitude,
      required this.longitude,
      required this.address})
      : _skill = skill,
        super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String user_id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String mobile_number;
  @override
  final String gender;
  @override
  final DateTime birth_date;
  @override
  final String professional_title;
  @override
  final String nationality;
  final List<String> _skill;
  @override
  List<String> get skill {
    if (_skill is EqualUnmodifiableListView) return _skill;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skill);
  }

  @override
  final String fcm_token;
  @override
  final bool is_online;
  @override
  final DateTime last_online;
  @override
  final bool in_chat;
  @override
  final String profile_url;
  @override
  final String cover_url;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;

  @override
  String toString() {
    return 'UserModel(user_id: $user_id, name: $name, email: $email, mobile_number: $mobile_number, gender: $gender, birth_date: $birth_date, professional_title: $professional_title, nationality: $nationality, skill: $skill, fcm_token: $fcm_token, is_online: $is_online, last_online: $last_online, in_chat: $in_chat, profile_url: $profile_url, cover_url: $cover_url, latitude: $latitude, longitude: $longitude, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobile_number, mobile_number) ||
                other.mobile_number == mobile_number) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birth_date, birth_date) ||
                other.birth_date == birth_date) &&
            (identical(other.professional_title, professional_title) ||
                other.professional_title == professional_title) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            const DeepCollectionEquality().equals(other._skill, _skill) &&
            (identical(other.fcm_token, fcm_token) ||
                other.fcm_token == fcm_token) &&
            (identical(other.is_online, is_online) ||
                other.is_online == is_online) &&
            (identical(other.last_online, last_online) ||
                other.last_online == last_online) &&
            (identical(other.in_chat, in_chat) || other.in_chat == in_chat) &&
            (identical(other.profile_url, profile_url) ||
                other.profile_url == profile_url) &&
            (identical(other.cover_url, cover_url) ||
                other.cover_url == cover_url) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      user_id,
      name,
      email,
      mobile_number,
      gender,
      birth_date,
      professional_title,
      nationality,
      const DeepCollectionEquality().hash(_skill),
      fcm_token,
      is_online,
      last_online,
      in_chat,
      profile_url,
      cover_url,
      latitude,
      longitude,
      address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String user_id,
      required final String name,
      required final String email,
      required final String mobile_number,
      required final String gender,
      required final DateTime birth_date,
      required final String professional_title,
      required final String nationality,
      required final List<String> skill,
      required final String fcm_token,
      required final bool is_online,
      required final DateTime last_online,
      required final bool in_chat,
      required final String profile_url,
      required final String cover_url,
      required final double latitude,
      required final double longitude,
      required final String address}) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get user_id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get mobile_number;
  @override
  String get gender;
  @override
  DateTime get birth_date;
  @override
  String get professional_title;
  @override
  String get nationality;
  @override
  List<String> get skill;
  @override
  String get fcm_token;
  @override
  bool get is_online;
  @override
  DateTime get last_online;
  @override
  bool get in_chat;
  @override
  String get profile_url;
  @override
  String get cover_url;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
