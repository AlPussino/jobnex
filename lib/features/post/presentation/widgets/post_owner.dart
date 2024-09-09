import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_event.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_state.dart';

class PostOwner extends StatefulWidget {
  final String post_owner_id;
  final String created_at;
  const PostOwner({
    super.key,
    required this.post_owner_id,
    required this.created_at,
  });

  @override
  State<PostOwner> createState() => _PostOwnerState();
}

class _PostOwnerState extends State<PostOwner> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(widget.post_owner_id)),
      lazy: false,
      key: Key(widget.post_owner_id),
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

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                user['profile_url'])),
                        SizedBox(width: size.width / 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${user['name']}",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                            ),
                            Text(
                              widget.created_at,
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ],
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
