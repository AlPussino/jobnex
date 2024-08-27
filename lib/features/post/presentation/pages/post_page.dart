import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:freezed_example/features/post/presentation/pages/add_post_page.dart';
import 'package:freezed_example/features/post/presentation/pages/post_detail_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import '../../data/model/post.dart';

class PostPage extends StatefulWidget {
  static const routeName = '/post-page';

  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    context.read<PostBloc>().add(PostGetAllPost());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: BlocConsumer<PostBloc, PostState>(
        buildWhen: (previous, current) => current is PostGetPostsSuccessState,
        listenWhen: (previous, current) => current is PostFailure,
        listener: (context, state) {
          if (state is PostFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
        },
        builder: (context, state) {
          // Loading
          if (state is PostLoading) {
            return const LoadingWidget(caption: "Loading...");
          }

          // Failure
          if (state is PostFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }

          // Success
          if (state is PostGetPostsSuccessState) {
            return StreamBuilder(
              stream: state.posts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(caption: "");
                }
                List<Post>? postList = snapshot.data;
                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const ErrorWidgets(errorMessage: "ZER0 P0STS F0UND!");
                }
                if (snapshot.hasError) {
                  return ErrorWidgets(
                    errorMessage: snapshot.error.toString(),
                  );
                }
                return ListView.builder(
                  itemCount: postList!.length,
                  itemBuilder: (context, index) {
                    final post = postList[index];

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetailPage(post: post)));
                      },
                      child: Hero(
                        tag: post.text,
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: size.width / 1.5,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: post.image,
                                    fit: BoxFit.cover,
                                    height: size.width / 2,
                                    width: size.width,
                                  ),
                                ),
                                Text(
                                  post.text,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }

          // null state
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddPostPage(),
          ));
        },
        child: const Icon(Iconsax.add_outline),
      ),
    );
  }
}
