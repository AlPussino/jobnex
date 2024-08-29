import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/features/feed/presentation/widgets/user_card.dart';

class CandidatesList extends StatelessWidget {
  final Map<String, dynamic> JobRecruitmentData;

  const CandidatesList({
    super.key,
    required this.JobRecruitmentData,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> candidateList = JobRecruitmentData["candidates"];
    if (candidateList.isEmpty) {
      return const ErrorWidgets(errorMessage: "No candidate found.");
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: candidateList.length,
        itemBuilder: (context, index) {
          DocumentReference<Map<String, dynamic>> candidate =
              candidateList[index];

          return Card(
            child: StreamBuilder(
              stream: candidate.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(caption: "");
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }

                // return InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, ProfilePage.routeName,
                //         arguments: snapshot.data!['user_id']);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border: Border.all(color: AppPallete.lightBlue),
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             radius: 30,
                //             backgroundImage: CachedNetworkImageProvider(
                //                 snapshot.data!['profile_url']),
                //           ),
                //           SizedBox(width: size.width / 20),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 snapshot.data!['name'],
                //               ),
                //               Text(
                //                 snapshot.data!['email'],
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // );
                return UserCard(userData: snapshot.data!.data()!);
              },
            ),
          );
        },
      ),
    );
  }
}
