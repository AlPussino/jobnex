import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/common/widget/view_images_list_page.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:toastification/toastification.dart';

class ImagesGridWidgetInChatMediaTabBar extends StatefulWidget {
  final String chatRoomId;
  const ImagesGridWidgetInChatMediaTabBar(
      {super.key, required this.chatRoomId});

  @override
  State<ImagesGridWidgetInChatMediaTabBar> createState() =>
      _ImagesGridWidgetInChatMediaTabBarState();
}

class _ImagesGridWidgetInChatMediaTabBarState
    extends State<ImagesGridWidgetInChatMediaTabBar> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetImagesInChat(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) => current is ChatGetImagesInChatSuccess,
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
        if (state is ChatGetImagesInChatSuccess) {
          return StreamBuilder(
            stream: state.images,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(errorMessage: "No image");
              }
              List<QueryDocumentSnapshot<Map<String, dynamic>>> imagesList =
                  snapshot.data!.docs;

              imagesList.sort((a, b) {
                Timestamp timeA = a['time_sent'] as Timestamp;
                Timestamp timeB = b['time_sent'] as Timestamp;
                return timeA.compareTo(timeB);
              });

              List<String> imageUrls = [];
              for (var doc in imagesList) {
                List<dynamic> images = doc['message'];
                imageUrls.addAll(List<String>.from(images));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ViewImagesListPage.routeName,
                        arguments: {
                          "images": imageUrls,
                          "id": index,
                          "isOwner": false,
                        },
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: imageUrls[index],
                      cacheKey: imageUrls[index],
                      fit: BoxFit.cover,
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
