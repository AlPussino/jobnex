// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      user_id: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile_number: json['mobile_number'] as String,
      gender: json['gender'] as String,
      birth_date: DateTime.parse(json['birth_date'] as String),
      professional_title: json['professional_title'] as String,
      nationality: json['nationality'] as String,
      skill: (json['skill'] as List<dynamic>).map((e) => e as String).toList(),
      fcm_token: json['fcm_token'] as String,
      is_online: json['is_online'] as bool,
      last_online: DateTime.parse(json['last_online'] as String),
      in_chat: json['in_chat'] as bool,
      profile_url: json['profile_url'] as String,
      cover_url: json['cover_url'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'name': instance.name,
      'email': instance.email,
      'mobile_number': instance.mobile_number,
      'gender': instance.gender,
      'birth_date': instance.birth_date.toIso8601String(),
      'professional_title': instance.professional_title,
      'nationality': instance.nationality,
      'skill': instance.skill,
      'fcm_token': instance.fcm_token,
      'is_online': instance.is_online,
      'last_online': instance.last_online.toIso8601String(),
      'in_chat': instance.in_chat,
      'profile_url': instance.profile_url,
      'cover_url': instance.cover_url,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
