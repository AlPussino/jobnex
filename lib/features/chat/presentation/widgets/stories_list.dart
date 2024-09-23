import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:JobNex/features/chat/presentation/widgets/story_users_list.dart';
import 'package:toastification/toastification.dart';
import '../../data/model/story.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({super.key});

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetAllStories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) => current is ChatGetAllStoriesSuccess,
      listenWhen: (previous, current) => current is ChatFailure,
      listener: (context, state) {
        if (state is ChatFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return const LoadingWidget();
        }

        if (state is ChatFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }
        if (state is ChatGetAllStoriesSuccess) {
          return StreamBuilder(
            stream: state.stories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasError) {
                return ErrorWidgets(errorMessage: snapshot.error.toString());
              }
              List<Story> storyList = snapshot.data!;
              return Container(
                margin: const EdgeInsets.all(15),
                height: size.height / 8,
                child: ListView.builder(
                  addRepaintBoundaries: false,
                  addAutomaticKeepAlives: false,
                  itemCount: storyList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return StoryUsersList(story: storyList[index]);
                  },
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
