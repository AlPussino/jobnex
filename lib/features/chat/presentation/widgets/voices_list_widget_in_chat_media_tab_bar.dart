import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/widgets/audio_message.dart';
import 'package:toastification/toastification.dart';

class VoicesListWidgetInChatMediaTabBar extends StatefulWidget {
  final String chatRoomId;
  final Map<String, dynamic> chatRoomData;

  const VoicesListWidgetInChatMediaTabBar(
      {super.key, required this.chatRoomId, required this.chatRoomData});

  @override
  State<VoicesListWidgetInChatMediaTabBar> createState() =>
      _VoicesListWidgetInChatMediaTabBarState();
}

class _VoicesListWidgetInChatMediaTabBarState
    extends State<VoicesListWidgetInChatMediaTabBar> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetVoicesInChat(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) => current is ChatGetVoicesInChatSuccess,
      listenWhen: (previous, current) => current is ChatFailure,
      listener: (context, state) {
        if (state is ChatFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return const LoadingWidget(caption: "Loading...");
        }
        if (state is ChatFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }
        if (state is ChatGetVoicesInChatSuccess) {
          return StreamBuilder(
            stream: state.voices,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(caption: "");
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(errorMessage: "No audio");
              }
              final voicesList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: voicesList.length,
                itemBuilder: (context, index) {
                  final chatStreamData = voicesList[index].data();
                  return AudioMessage(
                    size: size,
                    chatData: chatStreamData,
                    chatListData: widget.chatRoomData,
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
