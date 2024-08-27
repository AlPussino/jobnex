import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/pages/chat_information_page.dart';
import 'package:freezed_example/features/chat/presentation/widgets/chat_inputs.dart';
import 'package:freezed_example/features/chat/presentation/widgets/message_list_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class ChatConversationPage extends StatefulWidget {
  static const routeName = '/chat-conversation-page';

  final Map<String, dynamic> receiverData;
  final String chatRoomId;
  const ChatConversationPage({
    super.key,
    required this.receiverData,
    required this.chatRoomId,
  });

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final messageController = TextEditingController();

  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetChatRoomData(widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fireAuth = FirebaseAuth.instance;

    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) => current is ChatGetChatRoomDataSuccuess,
      listenWhen: (previous, current) => current is ChatFailure,
      listener: (context, state) {
        if (state is ChatFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Scaffold(body: LoadingWidget(caption: ""));
        }
        //
        if (state is ChatFailure) {
          return Scaffold(body: ErrorWidgets(errorMessage: state.message));
        }
        if (state is ChatGetChatRoomDataSuccuess) {
          return StreamBuilder(
            stream: state.chatRoomData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(caption: "");
              } else if (snapshot.hasError) {
                return ErrorWidgets(errorMessage: snapshot.error.toString());
              }

              final chatRoomData = snapshot.data!.data();

              return Scaffold(
                appBar: AppBar(
                  title: ChatConversationAppBar(
                    receiverData: widget.receiverData,
                    chatRoomData: chatRoomData!,
                    size: size,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.call_bold,
                        color: AppPallete.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.video_bold,
                        color: AppPallete.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        !chatRoomData['block'] ||
                                chatRoomData['block_by'] ==
                                    fireAuth.currentUser!.uid
                            ? Navigator.pushNamed(
                                context,
                                ChatInformationPage.routeName,
                                arguments: {
                                  "receiverData": widget.receiverData,
                                  "chatRoomId": widget.chatRoomId,
                                  "chatRoomData": chatRoomData
                                },
                              )
                            : null;
                      },
                      icon: const Icon(
                        Iconsax.info_circle_bold,
                        color: AppPallete.white,
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: MessageListWidget(
                          receiverData: widget.receiverData,
                          messageController: messageController,
                          chatRoomData: chatRoomData,
                        ),
                      ),
                    ),
                    !chatRoomData['block']
                        ? ChatInputs(
                            receiverData: widget.receiverData,
                            messageController: messageController,
                            chatListData: chatRoomData,
                          )
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width,
                            color: Colors.black,
                            child: Center(
                                child: Text(
                                    "${chatRoomData['block_by'] == fireAuth.currentUser!.uid ? "You" : "Other"} blocked."))),
                  ],
                ),
              );
            },
          );
        }
        return const Scaffold();
      },
    );
  }
}

class ChatConversationAppBar extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  final Map<String, dynamic> chatRoomData;
  final Size size;
  const ChatConversationAppBar({
    super.key,
    required this.receiverData,
    required this.chatRoomData,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  CachedNetworkImageProvider(receiverData['profile_url']),
            ),
            CircleAvatar(
              radius: 6,
              backgroundColor: AppPallete.scaffoldBackgroundColor,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: receiverData['is_online']
                    ? AppPallete.green
                    : AppPallete.grey,
              ),
            )
          ],
        ),
        SizedBox(width: size.width / 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receiverData['name']),
            Text(
              receiverData['is_online']
                  ? "online"
                  : changeToTimeAgo(chatRoomData['last_online']),
              style: Theme.of(context).primaryTextTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
