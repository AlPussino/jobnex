import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:JobNex/features/chat/presentation/widgets/message_box.dart';
import 'package:toastification/toastification.dart';

class MessageListWidget extends StatefulWidget {
  final Map<String, dynamic> receiverData;
  final TextEditingController messageController;
  final Map<String, dynamic> chatRoomData;

  const MessageListWidget({
    super.key,
    required this.receiverData,
    required this.messageController,
    required this.chatRoomData,
  });

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  @override
  void initState() {
    context
        .read<ChatBloc>()
        .add(ChatGetChatMessages(widget.receiverData['user_id']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (previous, current) => current is ChatFailure,
      buildWhen: (previous, current) => current is ChatGetChatMessagesSuccess,
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

        if (state is ChatGetChatMessagesSuccess) {
          return StreamBuilder(
            stream: state.chatStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(
                    errorMessage: "No conversation found.");
              }
              final chatStreamSnapShot = snapshot.data!.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatStreamSnapShot.length,
                itemBuilder: (context, index) {
                  final chatStreamData = chatStreamSnapShot[index].data();
                  return MessageBox(
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
