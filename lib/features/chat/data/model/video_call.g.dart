// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoCallImpl _$$VideoCallImplFromJson(Map<String, dynamic> json) =>
    _$VideoCallImpl(
      caller_id: json['caller_id'] as String,
      receiver_id: json['receiver_id'] as String,
      is_accepted: json['is_accepted'] as bool,
    );

Map<String, dynamic> _$$VideoCallImplToJson(_$VideoCallImpl instance) =>
    <String, dynamic>{
      'caller_id': instance.caller_id,
      'receiver_id': instance.receiver_id,
      'is_accepted': instance.is_accepted,
    };
