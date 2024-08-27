import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/pages/update_quick_reaction_page.dart';
import 'package:freezed_example/features/chat/presentation/pages/update_theme_page.dart';
import 'package:freezed_example/features/chat/presentation/pages/view_media_page.dart';
import 'package:freezed_example/features/chat/presentation/widgets/chat_information_user_profile_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class ChatInformationPage extends StatelessWidget {
  static const routeName = '/chat-information-page';

  final Map<String, dynamic> receiverData;
  final Map<String, dynamic> chatRoomData;
  final String chatRoomId;

  const ChatInformationPage({
    super.key,
    required this.receiverData,
    required this.chatRoomData,
    required this.chatRoomId,
  });

  void deleteConversation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.end,
          alignment: Alignment.centerLeft,
          title: const Text("Delete Messages"),
          content: const Text("Are you sure you want to delete all messages?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                context
                    .read<ChatBloc>()
                    .add(ChatDeleteConversation(chatRoomId));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void blockUser(BuildContext context, bool is_block) {
    context.read<ChatBloc>().add(ChatBlockUser(chatRoomId, is_block));
  }

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Detail")),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatDeleteConversationSuccess) {
            SnackBars.showToastification(
                context, "Deleted successfully.", ToastificationType.success);
            Navigator.pop(context);
          }
          if (state is ChatBlockUserSuccess) {
            SnackBars.showToastification(
                context,
                state.is_block
                    ? "block sunncessfully."
                    : "unblock sunncessfully.",
                ToastificationType.success);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const LoadingWidget(caption: "");
          }
          if (state is ChatFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }

          return ListView(
            children: [
              ChatInformationUserProfileWidget(
                  userData: chatRoomData['chat_contact']),
              // Theme
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    UpdateThemePage.routeName,
                    arguments: {
                      "receiverData": receiverData,
                      "chatListData": chatRoomData,
                    },
                  );
                },
                leading: const Icon(Iconsax.paintbucket_bold),
                title: const Text("Theme"),
                subtitle: const Text("Update theme"),
                trailing: const Icon(Iconsax.arrow_circle_right_bold),
              ),

              // Quick Reaction
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    UpdateQuickReactionPage.routeName,
                    arguments: {
                      "receiverData": receiverData,
                      "chatListData": chatRoomData,
                    },
                  );
                },
                leading: const Icon(Iconsax.emoji_happy_bold),
                title: const Text("Quick reaction"),
                subtitle: const Text("Update Quick reaction"),
                trailing: const Icon(Iconsax.arrow_circle_right_bold),
              ),

              // View Media
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ViewMediaPage.routeName,
                    arguments: {
                      "chatRoomId": chatRoomId,
                      "chatRoomData": chatRoomData,
                    },
                  );
                },
                leading: const Icon(Iconsax.gallery_bold),
                title: const Text("View media"),
                subtitle: const Text("images, videos"),
                trailing: const Icon(Iconsax.arrow_circle_right_bold),
              ),

              // Block User
              ListTile(
                onTap: () {},
                leading: const Icon(Iconsax.message_remove_bold),
                title: const Text("Block user"),
                subtitle: const Text("FRIENDZONE!"),
                trailing: !chatRoomData['block'] ||
                        chatRoomData['block_by'] == fireAuth.currentUser!.uid
                    ? Switch(
                        value: chatRoomData['block'],
                        onChanged: (value) => blockUser(context, value),
                      )
                    : null,
              ),

              // Delete conversation
              ListTile(
                onTap: () => deleteConversation(context),
                leading: const Icon(Iconsax.trash_bold),
                title: const Text("Delete conversation"),
                subtitle: const Text("Clear your chat history"),
                trailing: const Icon(Iconsax.arrow_circle_right_bold),
              ),
            ],
          );
        },
      ),
    );
  }
}
