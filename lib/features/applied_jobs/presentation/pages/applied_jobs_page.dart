import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/applied_jobs/presentation/bloc/applied_jobs_bloc.dart';
import 'package:freezed_example/features/feed/presentation/pages/job_recruitment_detail_page.dart';
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
    final size = MediaQuery.sizeOf(context);
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
            return const LoadingWidget(caption: "Loading...");
          }
          if (state is AppliedJobsFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }
          if (state is AppliedJobsGetUserAppliedJobsSuccess) {
            return StreamBuilder(
              stream: state.appliedJobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(caption: "Loading...");
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
                          return const LoadingWidget(caption: "Loading...");
                        }
                        final feedData = snapshot.data!.data()!;
                        final feedId = snapshot.data!.id;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: InkWell(
                            highlightColor:
                                AppPallete.elevatedButtonBackgroundColor,
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                JobRecruitmentDetailPage.routeName,
                                arguments: {
                                  "jobRecruitmentData": feedData,
                                  "jobRecruitmentId": feedId,
                                },
                              );
                            },
                            child: Card(
                              child: Container(
                                width: size.width,
                                height: size.width / 2,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          feedData['company_name'],
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          changeToTimeAgo(
                                              feedData['created_at']),
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .displaySmall,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      feedData['job_position'],
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      feedData['role_responsibility'],
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .displaySmall,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Chip(
                                          label: Text(
                                            feedData['sallary_range'],
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .displaySmall,
                                          ),
                                        ),
                                        Text(
                                          feedData['job_location'],
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .displaySmall,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
