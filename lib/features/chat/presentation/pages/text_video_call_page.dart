import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/features/chat/data/model/video_call.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Call"),
      ),
      body: StreamBuilder(
        stream: fireStore
            .collection('users')
            .doc(fireAuth.currentUser!.uid)
            .collection('video_call')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return ErrorWidgets(errorMessage: snapshot.error.toString());
          } else if (snapshot.data!.docs.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fireStore
                        .collection('users')
                        .doc(widget.receiverData['user_id'])
                        .collection('video_call')
                        .doc(fireAuth.currentUser!.uid)
                        .set(VideoCall(
                                caller_id: fireAuth.currentUser!.uid,
                                receiver_id: widget.receiverData['user_id'])
                            .toJson());

                    //
                    fireStore
                        .collection('users')
                        .doc(fireAuth.currentUser!.uid)
                        .collection('video_call')
                        .doc(fireAuth.currentUser!.uid)
                        .set(VideoCall(
                                caller_id: fireAuth.currentUser!.uid,
                                receiver_id: widget.receiverData['user_id'])
                            .toJson());
                  },
                  child: const Text("call"),
                ),
              ],
            );
          }
          final videoCaller = VideoCall.fromJson(snapshot.data!.docs[0].data());
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(videoCaller.caller_id),
              ElevatedButton(
                onPressed: () async {
                  QuerySnapshot senderQuerySnapshot = await fireStore
                      .collection('users')
                      .doc(fireAuth.currentUser!.uid)
                      .collection('video_call')
                      .get();

                  WriteBatch senderBatch = fireStore.batch();

                  for (QueryDocumentSnapshot document
                      in senderQuerySnapshot.docs) {
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

                  for (QueryDocumentSnapshot document
                      in receiverQuerySnapshot.docs) {
                    receiverBatch.delete(document.reference);
                  }

                  await receiverBatch.commit();
                },
                child: const Text("hang up"),
              )
            ],
          );
        },
      ),
    );
  }
}
