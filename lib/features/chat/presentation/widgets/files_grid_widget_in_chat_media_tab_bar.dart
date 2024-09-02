import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/widgets/file_message.dart';
import 'package:toastification/toastification.dart';

class FilesGridWidgetInChatMediaTabBar extends StatefulWidget {
  final String chatRoomId;
  final Map<String, dynamic> chatRoomData;

  const FilesGridWidgetInChatMediaTabBar(
      {super.key, required this.chatRoomId, required this.chatRoomData});

  @override
  State<FilesGridWidgetInChatMediaTabBar> createState() =>
      _FilesGridWidgetInChatMediaTabBarState();
}

class _FilesGridWidgetInChatMediaTabBarState
    extends State<FilesGridWidgetInChatMediaTabBar> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetFilesInChat(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) => current is ChatGetFilesInChatSuccess,
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
        if (state is ChatGetFilesInChatSuccess) {
          return StreamBuilder(
            stream: state.files,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(errorMessage: "No file");
              }
              final filesList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: filesList.length,
                itemBuilder: (context, index) {
                  final chatStreamData = filesList[index].data();

                  return FileMessage(
                      size: size,
                      chatData: chatStreamData,
                      chatListData: widget.chatRoomData);
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
