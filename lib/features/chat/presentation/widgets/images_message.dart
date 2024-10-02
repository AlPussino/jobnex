import 'package:JobNex/core/common/widget/cached_network_image_widget.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/common/widget/view_images_list_page.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class ImagesMessage extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;
  const ImagesMessage(
      {super.key,
      required this.size,
      required this.chatData,
      required this.chatListData});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    List<String> imageList = [];

    if (chatData['message_type'] == MessageTypeEnum.image.type) {
      imageList = List<String>.from(chatData['message']);
    }
    return SwipeTo(
      key: UniqueKey(),
      offsetDx: 0.2,
      swipeSensitivity: 8,
      iconColor: AppPallete.lightBlue,
      animationDuration: const Duration(milliseconds: 100),
      onRightSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: imageList[0],
                message_type: MessageTypeEnum.image.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      onLeftSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: imageList[0],
                message_type: MessageTypeEnum.image.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      child: Container(
        width: size.width,
        alignment: chatData['sender_id'] == fireAuth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: imageList.length == 1
            ? SizedBox(
                height: size.height / 4,
                width: size.width / 3.5,
                child: imageList[0] == ""
                    ? const Card(
                        child: LoadingWidget(),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ViewImagesListPage.routeName,
                              arguments: {
                                "images": imageList.reversed.toList(),
                                "id": 0,
                                "isOwner": chatData['sender_id'] ==
                                    fireAuth.currentUser!.uid,
                              },
                            );
                          },
                          child:
                              CachedNetworkImageWidget(imageUrl: imageList[0]),
                        ),
                      ),
              )
            : SizedBox(
                width: size.width / 1.2,
                child: Directionality(
                  textDirection:
                      chatData['sender_id'] == fireAuth.currentUser!.uid
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    addSemanticIndexes: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      final image = imageList[index];
                      return image == ""
                          ? const Card(child: LoadingWidget())
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ViewImagesListPage.routeName,
                                    arguments: {
                                      "images": imageList,
                                      "id": index,
                                      "isOwner": chatData['sender_id'] ==
                                          fireAuth.currentUser!.uid,
                                    },
                                  );
                                },
                                child:
                                    CachedNetworkImageWidget(imageUrl: image),
                              ),
                            );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
