part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

final class PostGetAllPost extends PostEvent {}

final class PostAddPost extends PostEvent {
  final Post post;
  PostAddPost(this.post);
}

final class PostGetPostById extends PostEvent {
  final int post_id;
  PostGetPostById(this.post_id);
}
