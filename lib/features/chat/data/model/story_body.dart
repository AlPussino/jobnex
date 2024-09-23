import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_body.freezed.dart';
part 'story_body.g.dart';

@unfreezed
class StoryBody with _$StoryBody {
  const StoryBody._();

  factory StoryBody({
    required String image,
    required DateTime created_at,
  }) = _StoryBody;

  factory StoryBody.fromJson(Map<String, dynamic> json) =>
      _$StoryBodyFromJson(json);
}
