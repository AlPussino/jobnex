// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryBodyImpl _$$StoryBodyImplFromJson(Map<String, dynamic> json) =>
    _$StoryBodyImpl(
      image: json['image'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$StoryBodyImplToJson(_$StoryBodyImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'created_at': instance.created_at.toIso8601String(),
    };
