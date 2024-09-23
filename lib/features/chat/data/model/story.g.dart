// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
      story_owner_id: json['story_owner_id'] as String,
      stories: (json['stories'] as List<dynamic>)
          .map((e) => StoryBody.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'story_owner_id': instance.story_owner_id,
      'stories': instance.stories,
    };
