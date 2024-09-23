import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/features/post/data/model/reply.dart';
part 'comment.freezed.dart';
part 'comment.g.dart';

@unfreezed
class Comment with _$Comment {
  const Comment._();

  factory Comment({
    required String comment_id,
    required String comment_owner_id,
    required String comment,
    required List<Reply> replies,
    required DateTime created_at,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
