part of 'post_bloc.dart';

@immutable
sealed class PostState {
  const PostState();
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostFailure extends PostState {
  final String message;
  const PostFailure(this.message);
}

final class PostGetPostsSuccessState extends PostState {
  final Stream<List<Post>> posts;
  const PostGetPostsSuccessState({
    required this.posts,
  });
}

final class PostAddPostSuccessState extends PostState {}

final class PostGetPostByIdSuccessState extends PostState {
  final Stream<Post> post;
  const PostGetPostByIdSuccessState({required this.post});
}
