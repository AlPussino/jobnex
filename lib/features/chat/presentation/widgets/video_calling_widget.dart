import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_event.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class VideoCallingWidget extends StatelessWidget {
  final String receiver_id;
  final VoidCallback hangUp;
  const VideoCallingWidget(
      {super.key, required this.receiver_id, required this.hangUp});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(receiver_id)),
      lazy: false,
      key: Key(receiver_id),
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

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: size.height / 10),
                            CircleAvatar(
                              radius: 62,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: CachedNetworkImageProvider(
                                  user['profile_url'],
                                ),
                              ),
                            ),
                            Text(user['name']),
                            const Text('Calling....'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CircleAvatar(
                          backgroundColor: AppPallete.red,
                          radius: 40,
                          child: IconButton(
                            onPressed: hangUp,
                            icon: const Icon(
                              Iconsax.call_remove_bold,
                              color: AppPallete.white,
                            ),
                          ),
                        ),
                      )
                    ],
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
