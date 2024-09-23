import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:JobNex/features/chat/presentation/pages/add_story_page.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_contact_list_tile.dart';
import 'package:JobNex/features/chat/presentation/widgets/stories_list.dart';
import 'package:icons_plus/icons_plus.dart';
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
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddStoryPage.routeName);
              },
              icon: const Icon(Iconsax.gallery_add_bold)),
        ],
      ),

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
            return const LoadingWidget();
          }
          if (state is ChatFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }

          if (state is ChatGetChatListSuccess) {
            return StreamBuilder(
              stream: state.chatList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return const ErrorWidgets(errorMessage: "No Chat found.");
                }
                final chatListSnapShot = snapshot.data!.docs;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      const StoriesList(),

                      //
                      AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatListSnapShot.length,
                          itemBuilder: (context, index) {
                            //x
                            final chatListData = chatListSnapShot[index].data();
                            DocumentReference<Map<String, dynamic>>
                                chatContact = chatListData['chat_contact'];

                            return ChatContactListTile(
                              chatSnapshot: chatContact,
                              lastMessage: chatListData['last_message'],
                              index: index,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
