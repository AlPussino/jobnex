import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import 'package:JobNex/features/post/data/model/react.dart';
import 'package:JobNex/features/post/domain/usecase/add_post.dart';
import 'package:JobNex/features/post/domain/usecase/get_all_posts.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_by_id.dart';
import 'package:JobNex/features/post/domain/usecase/react_post.dart';
import '../../domain/usecase/comment_post.dart';
import '../../domain/usecase/delete_post.dart';
import '../../domain/usecase/reply_comment.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AddPost _addPost;
  final GetAllPosts _getAllPosts;
  final GetPostById _getPostById;
  final ReactPost _reactPost;
  final CommentPost _commentPost;
  final ReplyComment _replyComment;
  final DeletePost _deletePost;

  PostBloc({
    required AddPost addPost,
    required GetAllPosts getAllPosts,
    required GetPostById getPostById,
    required ReactPost reactPost,
    required CommentPost commentPost,
    required ReplyComment replyComment,
    required DeletePost deletePost,
  })  : _addPost = addPost,
        _getAllPosts = getAllPosts,
        _getPostById = getPostById,
        _reactPost = reactPost,
        _commentPost = commentPost,
        _replyComment = replyComment,
        _deletePost = deletePost,
        super(PostInitial()) {
    on<PostEvent>((_, emit) => emit(PostLoading()));
    on<PostGetAllPost>(onPostGetAllPosts);
    on<PostAddPost>(onPostAddPost);
    on<PostGetPostById>(onPostGetPostById);
    on<PostReactPost>(onPostReactPost);
    on<PostCommentPost>(onPostCommentPost);
    on<PostReplyComment>(onPostReplyComment);
    on<PostDeletePost>(onPostDeletePost);
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

  void onPostReactPost(PostReactPost event, Emitter<PostState> emit) async {
    final response = await _reactPost.call(
        ReactPostParams(postId: event.postId, reactList: event.reactList));

    response.fold((failure) => emit(PostFailure(failure.message)),
        (_) => emit(PostReactPostSuccessState()));
  }

  void onPostCommentPost(PostCommentPost event, Emitter<PostState> emit) async {
    final response = await _commentPost.call(CommentPostParams(
        postId: event.postId, commentText: event.commentText));

    response.fold((failure) => emit(PostFailure(failure.message)),
        (_) => emit(PostCommentPostSuccessState()));
  }

  void onPostReplyComment(
      PostReplyComment event, Emitter<PostState> emit) async {
    final response = await _replyComment.call(ReplyCommentParams(
        post_id: event.post_id,
        comment_id: event.comment_id,
        replyText: event.replyText));

    response.fold((failure) => emit(PostFailure(failure.message)),
        (_) => emit(PostReplyCommentSuccessState()));
  }

  void onPostDeletePost(PostDeletePost event, Emitter<PostState> emit) async {
    final response =
        await _deletePost.call(DeletePostParams(post_id: event.post_id));

    response.fold((failure) => emit(PostFailure(failure.message)),
        (_) => emit(PostDeletePostSuccessState()));
  }
}
