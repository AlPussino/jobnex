import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:freezed_example/features/post/presentation/widgets/post_owner.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class PostDetailPage extends StatefulWidget {
  static const routeName = '/post-detail-page';

  final String post_id;
  const PostDetailPage({super.key, required this.post_id});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  void initState() {
    context.read<PostBloc>().add(PostGetPostById(widget.post_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Post Detail")),
      body: BlocConsumer<PostBloc, PostState>(
        buildWhen: (previous, current) =>
            current is PostGetPostByIdSuccessState,
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
            return const LoadingWidget();
          }

          // Failure
          if (state is PostFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }

          // Success
          if (state is PostGetPostByIdSuccessState) {
            return StreamBuilder(
              stream: state.post,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return ErrorWidgets(errorMessage: "${snapshot.error}");
                }

                final post = snapshot.data!;

                return Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeInRight(
                                    from: 20,
                                    duration: const Duration(milliseconds: 300),
                                    delay: const Duration(milliseconds: 300),
                                    animate: true,
                                    curve: Curves.easeIn,
                                    child: PostOwner(
                                      post_owner_id: post.post_owner_id!,
                                      created_at:
                                          changeToTimeAgo("${post.created_at}"),
                                    ),
                                  ),
                                  SizedBox(height: size.height / 20),
                                  FadeInRight(
                                      from: 40,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      delay: const Duration(milliseconds: 300),
                                      animate: true,
                                      curve: Curves.easeIn,
                                      child: Text(post.post_title)),
                                  SizedBox(height: size.height / 20),
                                  FadeInRight(
                                    from: 60,
                                    duration: const Duration(milliseconds: 300),
                                    delay: const Duration(milliseconds: 300),
                                    animate: true,
                                    curve: Curves.easeIn,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: post.image,
                                        fit: BoxFit.cover,
                                        height: size.width / 2,
                                        width: size.width,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height / 20),
                                  FadeInRight(
                                      from: 80,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      delay: const Duration(milliseconds: 300),
                                      animate: true,
                                      curve: Curves.easeIn,
                                      child: Text(post.post_body)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.message_2_outline),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
          return const ErrorWidgets(errorMessage: "No active state.");
        },
      ),
    );
  }
}
