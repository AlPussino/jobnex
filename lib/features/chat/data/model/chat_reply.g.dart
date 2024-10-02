// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatReplyImpl _$$ChatReplyImplFromJson(Map<String, dynamic> json) =>
    _$ChatReplyImpl(
      message: json['message'] as String,
      message_type: json['message_type'] as String,
      message_owner_id: json['message_owner_id'] as String,
    );

Map<String, dynamic> _$$ChatReplyImplToJson(_$ChatReplyImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'message_type': instance.message_type,
      'message_owner_id': instance.message_owner_id,
    };
