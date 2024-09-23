import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import 'package:JobNex/features/post/presentation/bloc/post_bloc.dart';
import 'package:toastification/toastification.dart';

class PostEditPopUpMenuButton extends StatelessWidget {
  final Post post;
  const PostEditPopUpMenuButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    void deletePost(String postId) {
      context.read<PostBloc>().add(PostDeletePost(post.id));
    }

    //
    return BlocConsumer<PostBloc, PostState>(
      listenWhen: (previous, current) => current is PostDeletePostSuccessState,
      listener: (context, state) {
        if (state is PostDeletePostSuccessState) {
          SnackBars.showToastification(context, "Deleted post successfully.",
              ToastificationType.success);
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
        return PopupMenuButton<String>(
          icon: const Icon(Icons.more_horiz),
          onSelected: (String fileType) {
            switch (fileType) {
              case "delete":
                deletePost(post.post_owner_id);
                break;
              default:
                null;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: "delete",
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.delete),
                  Text("delete"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
