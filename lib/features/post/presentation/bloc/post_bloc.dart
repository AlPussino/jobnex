import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
import 'package:freezed_example/features/post/domain/usecase/add_post.dart';
import 'package:freezed_example/features/post/domain/usecase/get_all_posts.dart';
import 'package:freezed_example/features/post/domain/usecase/get_post_by_id.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AddPost _addPost;
  final GetAllPosts _getAllPosts;
  final GetPostById _getPostById;

  PostBloc({
    required AddPost addPost,
    required GetAllPosts getAllPosts,
    required GetPostById getPostById,
  })  : _addPost = addPost,
        _getAllPosts = getAllPosts,
        _getPostById = getPostById,
        super(PostInitial()) {
    on<PostEvent>((_, emit) => emit(PostLoading()));
    on<PostGetAllPost>(onPostGetAllPosts);
    on<PostAddPost>(onPostAddPost);
    on<PostGetPostById>(onPostGetPostById);
  }

  FutureOr<void> onPostGetAllPosts(
      PostGetAllPost event, Emitter<PostState> emit) async {
    final response = await _getAllPosts.call(NoParams());

    response.fold((failure) => emit(PostFailure(failure.message)),
        (posts) => emit(PostGetPostsSuccessState(posts: posts)));
  }

  void onPostAddPost(PostAddPost event, Emitter<PostState> emit) async {
    final response = await _addPost.call(AddPostParams(post: event.post));

    response.fold((failure) => emit(PostFailure(failure.message)),
        (_) => emit(PostAddPostSuccessState()));
  }

  FutureOr<void> onPostGetPostById(
      PostGetPostById event, Emitter<PostState> emit) async {
    final response =
        await _getPostById.call(GetPostByIdParams(postId: event.post_id));

    response.fold((failure) => emit(PostFailure(failure.message)),
        (post) => emit(PostGetPostByIdSuccessState(post: post)));
  }
}
