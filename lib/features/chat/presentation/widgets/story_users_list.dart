import 'package:JobNex/core/common/widget/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/story.dart';
import 'package:JobNex/features/chat/presentation/pages/view_story_page.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_event.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_state.dart';

class StoryUsersList extends StatefulWidget {
  final Story story;
  const StoryUsersList({super.key, required this.story});

  @override
  State<StoryUsersList> createState() => _StoryUsersListState();
}

class _StoryUsersListState extends State<StoryUsersList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(widget.story.story_owner_id)),
      lazy: false,
      key: Key(widget.story.story_owner_id),
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
                    Navigator.pushNamed(
                      context,
                      ViewStoryPage.routeName,
                      arguments: {
                        "story_bodies": widget.story.stories,
                        "story_owner_name": user['name'],
                        "story_owner_profile": user['profile_url'],
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: AppPallete.green,
                            child: CircleAvatar(
                              radius: 32,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImageWidget(
                                  imageUrl: user['profile_url'],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${user['name']}",
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
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
