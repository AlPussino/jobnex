import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/pages/chat_conversation_page.dart';
import 'package:toastification/toastification.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat-page';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatGetChatList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),

      //
      body: BlocConsumer<ChatBloc, ChatState>(
        buildWhen: (previous, current) => current is ChatGetChatListSuccess,
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

          if (state is ChatGetChatListSuccess) {
            return StreamBuilder(
              stream: state.chatList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(caption: "Loading...");
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return const ErrorWidgets(errorMessage: "No Chat found.");
                }
                final chatListSnapShot = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: chatListSnapShot.length,
                  itemBuilder: (context, index) {
                    final chatListData = chatListSnapShot[index].data();
                    DocumentReference<Map<String, dynamic>> chatContact =
                        chatListData['chat_contact'];

                    //
                    return StreamBuilder(
                      stream: chatContact.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget(caption: "");
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        }

                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ChatConversationPage.routeName,
                                arguments: {
                                  "receiverData": snapshot.data!.data(),
                                  "chatRoomId": snapshot.data!.id,
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: ListTile(
                              leading: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 27,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              snapshot.data!['profile_url']),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 8,
                                    child: CircleAvatar(
                                      radius: 6,
                                      backgroundColor:
                                          snapshot.data!['is_online']
                                              ? AppPallete.green
                                              : AppPallete.grey,
                                    ),
                                  )
                                ],
                              ),
                              title: Text(
                                snapshot.data!['name'],
                              ),
                              subtitle: Text(
                                chatListData['last_message'],
                                maxLines: 2,
                              ),
                              trailing: Text(
                                snapshot.data!['is_online']
                                    ? "online"
                                    : changeToTimeAgo(
                                        snapshot.data!['last_online'],
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }

          return const ErrorWidgets(errorMessage: "No active state.");
        },
      ),
    );
  }
}
