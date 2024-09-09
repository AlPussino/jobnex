// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReplyImpl _$$ReplyImplFromJson(Map<String, dynamic> json) => _$ReplyImpl(
      reply_id: json['reply_id'] as String,
      reply_owner_id: json['reply_owner_id'] as String,
      reply: json['reply'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ReplyImplToJson(_$ReplyImpl instance) =>
    <String, dynamic>{
      'reply_id': instance.reply_id,
      'reply_owner_id': instance.reply_owner_id,
      'reply': instance.reply,
      'created_at': instance.created_at.toIso8601String(),
    };
