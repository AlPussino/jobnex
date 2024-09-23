part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

final class PostGetAllPost extends PostEvent {}

final class PostAddPost extends PostEvent {
  final Post post;
  PostAddPost(this.post);
}

final class PostGetPostById extends PostEvent {
  final String post_id;
  PostGetPostById(this.post_id);
}

final class PostReactPost extends PostEvent {
  final String postId;
  final List<React> reactList;
  PostReactPost(this.postId, this.reactList);
}

final class PostCommentPost extends PostEvent {
  final String postId;
  final String commentText;
  PostCommentPost(this.postId, this.commentText);
}

final class PostReplyComment extends PostEvent {
  final String post_id;
  final String comment_id;
  final String replyText;
  PostReplyComment(this.post_id, this.comment_id, this.replyText);
}

final class PostDeletePost extends PostEvent {
  final String post_id;
  PostDeletePost(this.post_id);
}
