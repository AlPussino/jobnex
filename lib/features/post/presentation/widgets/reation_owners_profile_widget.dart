import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/features/post/data/model/react.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_event.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_state.dart';
import 'package:JobNex/features/profile/presentation/pages/profile_page.dart';

class ReactOwnerProfile extends StatelessWidget {
  final String react_owner_id;
  final Map<String, Icon> reactionIcons;
  final React react;

  const ReactOwnerProfile(
      {super.key,
      required this.react_owner_id,
      required this.reactionIcons,
      required this.react});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(react_owner_id)),
      lazy: false,
      key: Key(react_owner_id),
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

                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName,
                        arguments: user['user_id']);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: CachedNetworkImageProvider(
                                user['profile_url'],
                              ),
                            ),
                            Positioned(
                              right: -10,
                              bottom: -4,
                              child: CircleAvatar(
                                radius: 14,
                                child: reactionIcons[react.react] ??
                                    const Icon(Icons.help_outline),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: size.width / 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user['name']),
                          ],
                        )
                      ],
                    ),
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
