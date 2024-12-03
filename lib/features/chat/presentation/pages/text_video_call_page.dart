import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/features/chat/data/model/video_call.dart';
import 'package:JobNex/features/chat/presentation/pages/video_calling_page.dart';
import 'package:JobNex/features/chat/presentation/widgets/video_call_dismissed_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/video_calling_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestVideoCallPage extends StatefulWidget {
  final Map<String, dynamic> receiverData;
  const TestVideoCallPage({super.key, required this.receiverData});

  @override
  State<TestVideoCallPage> createState() => _TestVideoCallPageState();
}

class _TestVideoCallPageState extends State<TestVideoCallPage> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  @override
  void dispose() {
    hangUp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: fireStore
            .collection('users')
            .doc(widget.receiverData['user_id'])
            .collection('video_call')
            .snapshots(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          // Error
          else if (snapshot.hasError) {
            return ErrorWidgets(errorMessage: snapshot.error.toString());
          }

          // Ready to call
          else if (snapshot.data!.docs.isEmpty) {
            return VideoCallDismissedWidget(call: call);
          }

          // In another call
          final videoCaller = VideoCall.fromJson(snapshot.data!.docs[0].data());
          if (videoCaller.caller_id == fireAuth.currentUser!.uid &&
              !videoCaller.is_accepted) {
            return VideoCallingWidget(
              receiver_id: videoCaller.receiver_id,
              hangUp: hangUp,
            );
          }

          //
          else if (videoCaller.caller_id == fireAuth.currentUser!.uid &&
              videoCaller.is_accepted) {
            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text("PICKEDss"),
            //       CircleAvatar(
            //         backgroundColor: AppPallete.red,
            //         radius: 40,
            //         child: IconButton(s
            //           onPressed: hangUp,
            //           icon: const Icon(
            //             Iconsax.call_remove_bold,
            //             color: AppPallete.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
            return VideoCallingPage(
              receiver_id: widget.receiverData['user_id'],
              channel: videoCaller.caller_id,
            );
          }

          //
          else {
            return const Center(
              child: Text("in another call"),
            );
          }
        },
      ),
    );
  }

  void call() async {
    await fireStore
        .collection('users')
        .doc(widget.receiverData['user_id'])
        .collection('video_call')
        .doc(fireAuth.currentUser!.uid)
        .set(VideoCall(
          caller_id: fireAuth.currentUser!.uid,
          receiver_id: widget.receiverData['user_id'],
          is_accepted: false,
        ).toJson());

    //
    await fireStore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .collection('video_call')
        .doc(widget.receiverData['user_id'])
        .set(VideoCall(
          caller_id: fireAuth.currentUser!.uid,
          receiver_id: widget.receiverData['user_id'],
          is_accepted: false,
        ).toJson());
  }

  void hangUp() async {
    QuerySnapshot senderQuerySnapshot = await fireStore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .collection('video_call')
        .get();

    WriteBatch senderBatch = fireStore.batch();

    for (QueryDocumentSnapshot document in senderQuerySnapshot.docs) {
      senderBatch.delete(document.reference);
    }

    await senderBatch.commit();

    //
    QuerySnapshot receiverQuerySnapshot = await fireStore
        .collection('users')
        .doc(widget.receiverData['user_id'])
        .collection('video_call')
        .get();

    WriteBatch receiverBatch = fireStore.batch();

    for (QueryDocumentSnapshot document in receiverQuerySnapshot.docs) {
      receiverBatch.delete(document.reference);
    }

    await receiverBatch.commit();
  }
}
