import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/common/widget/view_image_page.dart';
import 'package:JobNex/core/util/change_date_format.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_conversation_page.dart';
import 'package:JobNex/features/profile/presentation/bloc/user_bloc.dart';
import 'package:JobNex/features/profile/presentation/pages/change_contacts.page.dart';
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
        buildWhen: (previous, current) => current is UserSuccess,
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
            return const LoadingWidget();
          }
          if (state is UserFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }

          if (state is UserSuccess) {
            return StreamBuilder(
              stream: state.userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                final snapShotData = snapshot.data!.data();
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    FadeInLeft(
                      from: 20,
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 300),
                      animate: true,
                      curve: Curves.easeIn,
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
                                          if (widget.user_id ==
                                              fireAuth.currentUser!.uid)
                                            CircleAvatar(
                                              child: IconButton(
                                                onPressed: changeCoverImage,
                                                icon: const Icon(
                                                  Iconsax.camera_bold,
                                                ),
                                              ),
                                            ),
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
                                            Text(snapShotData['name']),
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
                                        child: CircleAvatar(
                                          radius: 60,
                                          foregroundImage:
                                              CachedNetworkImageProvider(
                                            snapShotData['profile_url'],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (widget.user_id ==
                                        fireAuth.currentUser!.uid)
                                      CircleAvatar(
                                        radius: 20,
                                        child: IconButton(
                                          onPressed: changeProfileImage,
                                          icon: const Icon(
                                              Iconsax.refresh_circle_bold),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                //
                                Navigator.pushNamed(
                                  context,
                                  ChatConversationPage.routeName,
                                  arguments: {
                                    "receiverData": snapShotData,
                                    "chatRoomId": widget.user_id,
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is ChatLoading) {
                                return const LoadingWidget();
                              }
                              return FadeInLeft(
                                from: 40,
                                duration: const Duration(milliseconds: 300),
                                delay: const Duration(milliseconds: 300),
                                animate: true,
                                curve: Curves.easeIn,
                                child: Row(
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
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                    FadeInLeft(
                      from: 60,
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 300),
                      animate: true,
                      curve: Curves.easeIn,
                      child: ListTile(
                        title: const Text("Personal Information"),
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
                      ),
                    ),
                    FadeInLeft(
                      from: 80,
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 300),
                      animate: true,
                      curve: Curves.easeIn,
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Iconsax.profile_circle_bold),
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
                                subtitle: Text(changeDateFormat(
                                    snapShotData['birth_date'])),
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
