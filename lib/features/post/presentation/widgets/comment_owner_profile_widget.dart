import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_event.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_state.dart';

class CommentOrReplyOwnerProfileWidget extends StatelessWidget {
  final String owner_id;
  const CommentOrReplyOwnerProfileWidget({
    super.key,
    required this.owner_id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(owner_id)),
      lazy: false,
      key: Key(owner_id),
      child: BlocBuilder<PostOwnerBloc, PostOwnerState>(
        buildWhen: (previous, current) => current is PostOwnerLoaded,
        builder: (context, state) {
          // Loading
          if (state is PostOwnerLoading) {
            return const LoadingWidget();
          }

          // Failure
          if (state is PostOwnerError) {
            return ErrorWidgets(errorMessage: state.message);
          }

          // Success
          if (state is PostOwnerLoaded) {
            return StreamBuilder(
              stream: state.postOwnerData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingWidget());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                final user = snapshot.data!.data()!;

                return CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    user['profile_url'],
                  ),
                );
              },
            );
          }

          // No Avtive staet
          return const SizedBox();
        },
      ),
    );
  }
}
