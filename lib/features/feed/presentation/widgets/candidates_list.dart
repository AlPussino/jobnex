import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/features/feed/presentation/widgets/user_card.dart';

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
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }

                return UserCard(userData: snapshot.data!.data()!);
              },
            ),
          );
        },
      ),
    );
  }
}
