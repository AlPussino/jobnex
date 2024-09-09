// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      comment_id: json['comment_id'] as String,
      comment_owner_id: json['comment_owner_id'] as String,
      comment: json['comment'] as String,
      replies: (json['replies'] as List<dynamic>)
          .map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'comment_id': instance.comment_id,
      'comment_owner_id': instance.comment_owner_id,
      'comment': instance.comment,
      'replies': instance.replies,
      'created_at': instance.created_at.toIso8601String(),
    };
