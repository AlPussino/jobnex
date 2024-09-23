import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/features/chat/data/model/story_body.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@unfreezed
class Story with _$Story {
  const Story._();

  factory Story({
    required String story_owner_id,
    required List<StoryBody> stories,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
