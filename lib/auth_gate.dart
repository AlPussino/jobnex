import 'dart:developer';
import 'package:JobNex/features/chat/data/model/video_call.dart';
import 'package:JobNex/features/chat/presentation/widgets/video_call_incoming_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/features/bottom_navigation_bar_page.dart';
import 'features/auth/presentation/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  static const routeName = '/auth-gate-page';

  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    // return fireAuth.currentUser == null
    //     ? const LoginPage()
    //     : const BottomNavigationBarPage();
    return fireAuth.currentUser == null
        ? const LoginPage()
        : const CheckIncomingCallPage();
  }
}

class CheckIncomingCallPage extends StatefulWidget {
  const CheckIncomingCallPage({super.key});

  @override
  State<CheckIncomingCallPage> createState() => _CheckIncomingCallPageState();
}

class _CheckIncomingCallPageState extends State<CheckIncomingCallPage> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              snapshot.data!.docs.isNotEmpty) {
            log("has data , not null , not empty");
            final videoCaller =
                VideoCall.fromJson(snapshot.data!.docs[0].data());

            if (videoCaller.receiver_id == fireAuth.currentUser!.uid) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoCallIncomingWidget(
                      hangUp: () => hangUp(callerId: videoCaller.caller_id),
                      videoCall: videoCaller,
                    ),
                  ),
                );
              });
            }
          }

          //

          return const BottomNavigationBarPage();
        },
      ),
    );
  }

  void hangUp({required String callerId}) async {
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
        .doc(callerId)
        .collection('video_call')
        .get();

    WriteBatch receiverBatch = fireStore.batch();

    for (QueryDocumentSnapshot document in receiverQuerySnapshot.docs) {
      receiverBatch.delete(document.reference);
    }

    await receiverBatch.commit();
  }
}
