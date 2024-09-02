// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String?,
      post_title: json['post_title'] as String,
      post_body: json['post_body'] as String,
      image: json['image'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      post_owner_id: json['post_owner_id'] as String?,
      reacts: (json['reacts'] as List<dynamic>)
          .map((e) => React.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_title': instance.post_title,
      'post_body': instance.post_body,
      'image': instance.image,
      'created_at': instance.created_at.toIso8601String(),
      'post_owner_id': instance.post_owner_id,
      'reacts': instance.reacts,
      'comments': instance.comments,
    };
