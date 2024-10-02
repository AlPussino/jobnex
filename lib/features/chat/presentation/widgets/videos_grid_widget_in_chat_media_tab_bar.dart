import 'package:JobNex/features/chat/presentation/widgets/video_thumbnail_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/common/widget/view_video_page.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:toastification/toastification.dart';

class VideosGridWidgetInChatMediaTabBar extends StatefulWidget {
  final String chatRoomId;

  const VideosGridWidgetInChatMediaTabBar(
      {super.key, required this.chatRoomId});

  @override
  State<VideosGridWidgetInChatMediaTabBar> createState() =>
      _VideosGridWidgetInChatMediaTabBarState();
}

class _VideosGridWidgetInChatMediaTabBarState
    extends State<VideosGridWidgetInChatMediaTabBar> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetVideosInChat(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) => current is ChatGetVideosInChatSuccess,
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
        if (state is ChatGetVideosInChatSuccess) {
          return StreamBuilder(
            stream: state.videos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(errorMessage: "No video");
              }
              List<QueryDocumentSnapshot<Map<String, dynamic>>> videosList =
                  snapshot.data!.docs;

              videosList.sort((a, b) {
                Timestamp timeA = a['time_sent'] as Timestamp;
                Timestamp timeB = b['time_sent'] as Timestamp;
                return timeA.compareTo(timeB);
              });

              List<String> videosUrls = [];
              for (var doc in videosList) {
                List<dynamic> videos = doc['message'];
                videosUrls.addAll(List<String>.from(videos));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: videosUrls.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ViewVideoPage.routeName,
                          arguments: videosUrls[index]);
                    },
                    child: VideoThumbnailImage(
                      videoUrl: videosUrls[index],
                      isChat: false,
                    ),
                  );
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
