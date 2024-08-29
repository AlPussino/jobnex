import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/common/widget/view_images_list_page.dart';

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
    return Container(
      width: size.width,
      alignment: chatData['sender_id'] == fireAuth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: imageList.length == 1
          ? SizedBox(
              height: size.height / 4,
              width: size.width / 3,
              child: imageList[0] == ""
                  ? const Card(child: LoadingWidget(caption: ""))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
                        child: CachedNetworkImage(
                          cacheKey: imageList[0],
                          imageUrl: imageList[0],
                          fit: BoxFit.cover,
                        ),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    final image = imageList[index];
                    return image == ""
                        ? const Card(child: LoadingWidget(caption: ""))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
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
                              child: CachedNetworkImage(
                                cacheKey: image,
                                imageUrl: image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
    );
  }
}
