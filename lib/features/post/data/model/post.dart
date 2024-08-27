import 'package:freezed_annotation/freezed_annotation.dart';
part 'post.freezed.dart';
part 'post.g.dart';

@unfreezed
class Post with _$Post {
  const Post._();

  factory Post({
    required String text,
    required String image,
    required DateTime created_at,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
