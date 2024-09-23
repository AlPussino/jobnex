import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:JobNex/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:toastification/toastification.dart';

class JobApplyButton extends StatefulWidget {
  final List<dynamic> candiateList;
  final Map<String, dynamic> JobRecruitmentData;
  final String jobRecruitmentId;

  const JobApplyButton({
    super.key,
    required this.candiateList,
    required this.JobRecruitmentData,
    required this.jobRecruitmentId,
  });

  @override
  State<JobApplyButton> createState() => _JobApplyButtonState();
}

class _JobApplyButtonState extends State<JobApplyButton> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  void applyJob({required List<dynamic> candidateList}) {
    context
        .read<FeedBloc>()
        .add(FeedApplyJob(widget.jobRecruitmentId, candidateList));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FeedFailure) {
          return SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
        if (state is FeedApplyJobSuccessState) {
          context.read<FeedBloc>().add(FeedGetAllJobRecruitments());
          return SnackBars.showToastification(context,
              "Successfully applied this job.", ToastificationType.success);
        }
      },
      builder: (context, state) {
        if (state is FeedLoading) {
          return const LoadingWidget();
        }
        return Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: widget.candiateList.contains(fireStore
                    .collection("users")
                    .doc(fireAuth.currentUser!.uid))
                ? ElevatedButton(
                    onPressed: () {},
                    child: const Text("Applied"),
                  )
                : ElevatedButtons(
                    buttonName: "Apply Now",
                    onPressed: () {
                      List<dynamic> candiateList =
                          widget.JobRecruitmentData["candidates"];
                      candiateList.add(fireStore
                          .collection("users")
                          .doc(fireAuth.currentUser!.uid));
                      applyJob(candidateList: candiateList);
                    },
                  ),
          ),
        );
      },
    );
  }
}
