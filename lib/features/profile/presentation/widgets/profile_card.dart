import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/common/widget/view_image_page.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_date_format.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/pages/chat_conversation_page.dart';
import 'package:freezed_example/features/profile/presentation/bloc/user_bloc.dart';
import 'package:freezed_example/features/profile/presentation/pages/change_contacts.page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class ProfileCard extends StatefulWidget {
  final String user_id;
  const ProfileCard({super.key, required this.user_id});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final fireAuth = FirebaseAuth.instance;
  @override
  void initState() {
    log("PP Build");
    context.read<UserBloc>().add(UserGetUserInfo(widget.user_id));
    super.initState();
  }

  void changeProfileImage() async {
    XFile? pickedXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedXFile != null) {
      File imageFile = File(pickedXFile.path);
      context.read<UserBloc>().add(UserChangeProfileImage(imageFile));
    }
  }

  void changeCoverImage() async {
    XFile? pickedXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedXFile != null) {
      File imageFile = File(pickedXFile.path);
      context.read<UserBloc>().add(UserChangeCoverImage(imageFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<UserBloc, UserState>(
        listenWhen: (previous, current) => current is UserFailure,
        buildWhen: (previous, current) => current is! UserActionState,
        listener: (context, state) {
          if (state is UserFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is UserChangeProfileImageSuccess) {
            SnackBars.showToastification(context,
                "Profile changed successfully.", ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo(widget.user_id));
          }
          if (state is UserChangeCoverImageSuccess) {
            SnackBars.showToastification(context, "Cover changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo(widget.user_id));
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const LoadingWidget(caption: "");
          }
          if (state is UserFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }

          if (state is UserSuccess) {
            return StreamBuilder(
              stream: state.userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(caption: "");
                }
                final snapShotData = snapshot.data!.data();
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: SizedBox(
                        height: size.width,
                        width: size.width,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              ViewImagePage.routeName,
                                              arguments:
                                                  snapShotData['cover_url'],
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  snapShotData!['cover_url'],
                                              fit: BoxFit.cover,
                                              width: size.width,
                                            ),
                                          ),
                                        ),
                                        widget.user_id ==
                                                fireAuth.currentUser!.uid
                                            ? IconButton(
                                                onPressed: changeCoverImage,
                                                icon: const Icon(
                                                  Iconsax.camera_bold,
                                                  color: AppPallete
                                                      .elevatedButtonBackgroundColor,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapShotData['name'],
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyMedium,
                                          ),
                                          Text(snapShotData[
                                              'professional_title']),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ViewImagePage.routeName,
                                          arguments:
                                              snapShotData['profile_url']);
                                    },
                                    child: CircleAvatar(
                                      radius: 65,
                                      backgroundColor:
                                          AppPallete.scaffoldBackgroundColor,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor:
                                            AppPallete.scaffoldBackgroundColor,
                                        foregroundImage:
                                            CachedNetworkImageProvider(
                                          snapShotData['profile_url'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  widget.user_id == fireAuth.currentUser!.uid
                                      ? CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              AppPallete.cardBackgroundColor,
                                          child: IconButton(
                                            onPressed: changeProfileImage,
                                            icon: const Icon(
                                              Iconsax.refresh_circle_bold,
                                              color: AppPallete
                                                  .elevatedButtonBackgroundColor,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(height: size.height / 40),
                    widget.user_id != fireAuth.currentUser!.uid
                        ? BlocConsumer<ChatBloc, ChatState>(
                            listener: (context, state) {
                              if (state is ChatFailure) {
                                SnackBars.showToastification(context,
                                    state.message, ToastificationType.error);
                              }
                              if (state is ChatCreatChatsuccess) {
                                SnackBars.showToastification(
                                    context,
                                    "Creating chat Success.",
                                    ToastificationType.success);
                              }
                            },
                            builder: (context, state) {
                              if (state is ChatLoading) {
                                return const LoadingWidget(caption: "");
                              }
                              return Row(
                                children: [
                                  const Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Icon(Iconsax.call_bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width / 40),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        context.read<ChatBloc>().add(
                                            ChatCreateChat(
                                                widget.user_id,
                                                "Hello 🙌🙌",
                                                MessageTypeEnum.text));
                                        //
                                        Navigator.pushNamed(
                                          context,
                                          ChatConversationPage.routeName,
                                          arguments: {
                                            "receiverData": snapShotData,
                                            "chatRoomId": widget.user_id,
                                          },
                                        );
                                      },
                                      child: const Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Icon(Iconsax.message_bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : const SizedBox(),
                    ListTile(
                      title: const Text("Contacts"),
                      trailing: widget.user_id == fireAuth.currentUser!.uid
                          ? IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ChangeContactsPage.routeName,
                                    arguments: snapShotData);
                              },
                              icon: const Icon(Iconsax.card_edit_bold),
                            )
                          : const SizedBox(),
                      iconColor: AppPallete.white,
                    ),
                    Card(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Iconsax.profile_circle_bold),
                              title: const Text("Gender"),
                              subtitle: Text(snapShotData['gender']),
                            ),
                            ListTile(
                              leading: const Icon(Iconsax.flag_bold),
                              title: const Text("Nationality"),
                              subtitle: Text(snapShotData['nationality']),
                            ),
                            ListTile(
                              leading: const Icon(Iconsax.calendar_1_bold),
                              title: const Text("Birth Date"),
                              subtitle: Text(
                                  changeDateFormat(snapShotData['birth_date'])),
                            ),
                            ListTile(
                              leading: const Icon(Iconsax.message_2_bold),
                              title: const Text("Email"),
                              subtitle: Text(snapShotData['email']),
                            ),
                            ListTile(
                              leading: const Icon(Iconsax.call_bold),
                              title: const Text("Mobile Number"),
                              subtitle: Text(snapShotData['mobile_number']),
                            ),
                            ListTile(
                              leading: const Icon(Iconsax.house_bold),
                              title: const Text("Address"),
                              subtitle: Text(snapShotData['address']),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
          return IconButton(
            onPressed: () {
              context.read<UserBloc>().add(UserGetUserInfo(widget.user_id));
            },
            icon: const Icon(Icons.refresh, size: 40),
          );
        },
      ),
    );
  }
}
