import 'dart:developer';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/video_call.dart';
import 'package:JobNex/features/chat/presentation/pages/video_calling_page.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_event.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class VideoCallIncomingWidget extends StatefulWidget {
  final VideoCall videoCall;
  final VoidCallback hangUp;
  const VideoCallIncomingWidget(
      {super.key, required this.hangUp, required this.videoCall});

  @override
  State<VideoCallIncomingWidget> createState() =>
      _VideoCallIncomingWidgetState();
}

class _VideoCallIncomingWidgetState extends State<VideoCallIncomingWidget> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: StreamBuilder(
          stream: fireStore
              .collection('users')
              .doc(fireAuth.currentUser!.uid)
              .collection('video_call')
              .snapshots(),
          builder: (context, snapshot) {
            //
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            } else if (widget.videoCall.receiver_id ==
                    fireAuth.currentUser!.uid &&
                widget.videoCall.is_accepted) {
              return VideoCallingPage(
                receiver_id: widget.videoCall.caller_id,
                channel: widget.videoCall.caller_id,
              );
            }

            return BlocProvider(
              create: (context) =>
                  PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
                    ..add(FetchPostOwner(widget.videoCall.caller_id)),
              lazy: false,
              key: Key(widget.videoCall.caller_id),
              child: BlocBuilder<PostOwnerBloc, PostOwnerState>(
                buildWhen: (previous, current) => current is PostOwnerLoaded,
                builder: (context, state) {
                  // Loading
                  if (state is PostOwnerLoading) {
                    return const LoadingWidget();
                  }

                  // Failure
                  if (state is PostOwnerError) {
                    return ErrorWidgets(errorMessage: state.message);
                  }

                  // Success
                  if (state is PostOwnerLoaded) {
                    return StreamBuilder(
                      stream: state.postOwnerData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: LoadingWidget());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        }
                        final user = snapshot.data!.data()!;

                        return Center(
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height / 10),
                                    CircleAvatar(
                                      radius: 62,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          user['profile_url'],
                                        ),
                                      ),
                                    ),
                                    Text(user['name']),
                                    const Text('Incoming call ....'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppPallete.red,
                                      radius: 40,
                                      child: IconButton(
                                        onPressed: widget.hangUp,
                                        icon: const Icon(
                                          Iconsax.call_remove_bold,
                                          color: AppPallete.white,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: AppPallete.green,
                                      radius: 40,
                                      child: IconButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           const VideoCallingPage(),
                                          //     ));
                                          acceptCall();
                                        },
                                        icon: const Icon(
                                          Iconsax.call_bold,
                                          color: AppPallete.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }

                  // No Avtive staet
                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void acceptCall() async {
    final receiverDocRef = fireStore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .collection('video_call')
        .doc(widget.videoCall.caller_id);

    final receiverDocSnapshot = await receiverDocRef.get();

    if (receiverDocSnapshot.exists) {
      await receiverDocRef.update({'is_accepted': true});
    } else {
      log('Document does not exist.');
    }

    //

    final callerDocRef = fireStore
        .collection('users')
        .doc(widget.videoCall.caller_id)
        .collection('video_call')
        .doc(fireAuth.currentUser!.uid);

    final callDocSnapshot = await callerDocRef.get();

    if (callDocSnapshot.exists) {
      await callerDocRef.update({'is_accepted': true});
    } else {
      log('Document does not exist.');
    }
  }
}
