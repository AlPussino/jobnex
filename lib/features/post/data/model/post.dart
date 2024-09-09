import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_example/features/post/data/model/comment.dart';
import 'package:freezed_example/features/post/data/model/react.dart';
part 'post.freezed.dart';
part 'post.g.dart';

@unfreezed
class Post with _$Post {
  const Post._();

  factory Post({
    required String id,
    required String post_title,
    required String post_body,
    required String image,
    required DateTime created_at,
    required String post_owner_id,
    required List<React> reacts,
    required List<Comment> comments,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
