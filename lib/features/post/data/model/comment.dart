import 'package:freezed_annotation/freezed_annotation.dart';
part 'comment.freezed.dart';
part 'comment.g.dart';

@unfreezed
class Comment with _$Comment {
  const Comment._();

  factory Comment({
    required String comment_owner_id,
    required String comment,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
