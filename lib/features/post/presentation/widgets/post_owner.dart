import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_event.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_state.dart';
import 'package:JobNex/features/post/presentation/widgets/post_edit_pop_up_menu_button.dart';
import 'package:JobNex/features/profile/presentation/pages/profile_page.dart';

class PostOwner extends StatelessWidget {
  final String created_at;
  final Post post;
  const PostOwner({
    super.key,
    required this.post,
    required this.created_at,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fireAuth = FirebaseAuth.instance;

    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(post.post_owner_id)),
      lazy: false,
      key: Key(post.post_owner_id),
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
                  highlightColor: AppPallete.lightBlue,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName,
                        arguments: post.post_owner_id);
                  },
                  child: Row(
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
                                created_at,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (fireAuth.currentUser!.uid == post.post_owner_id)
                        PostEditPopUpMenuButton(post: post),
                    ],
                  ),
                );
              },
            );
          }

          // No Avtive state
          return const SizedBox();
        },
      ),
    );
  }
}
