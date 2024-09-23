import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/applied_jobs/presentation/bloc/applied_jobs_bloc.dart';
import 'package:JobNex/features/feed/presentation/widgets/job_recruitment_card.dart';
import 'package:toastification/toastification.dart';

class AppliedJobsPage extends StatefulWidget {
  static const routeName = '/applied-jobs-page';

  const AppliedJobsPage({super.key});

  @override
  State<AppliedJobsPage> createState() => _AppliedJobsPageState();
}

class _AppliedJobsPageState extends State<AppliedJobsPage> {
  final fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    context
        .read<AppliedJobsBloc>()
        .add(AppliedJobsGetUserAppliedJobs(fireAuth.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Applied Jobs"),
      ),
      body: BlocConsumer<AppliedJobsBloc, AppliedJobsState>(
        listener: (context, state) {
          if (state is AppliedJobsFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is AppliedJobsLoading) {
            return const LoadingWidget();
          }
          if (state is AppliedJobsFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }
          if (state is AppliedJobsGetUserAppliedJobsSuccess) {
            return StreamBuilder(
              stream: state.appliedJobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return const ErrorWidgets(
                      errorMessage: "No Applied Jobs found.");
                }
                final appliedJobsSnapshot = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: appliedJobsSnapshot.length,
                  itemBuilder: (context, index) {
                    final appliedJobsData = appliedJobsSnapshot[index].data();
                    DocumentReference<Map<String, dynamic>> appliedJobsMap =
                        appliedJobsData['job_recruitments'];
                    return StreamBuilder(
                      stream: appliedJobsMap.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget();
                        }
                        final recruitmentData = snapshot.data!.data()!;
                        final recruitmentId = snapshot.data!.id;
                        return JobRecruitmentCard(
                          recruitmentData: recruitmentData,
                          recruitmentId: recruitmentId,
                          index: index,
                        );
                      },
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
