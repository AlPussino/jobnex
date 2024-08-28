import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/feed/presentation/pages/job_recruitment_detail_page.dart';
import 'package:freezed_example/features/profile/presentation/bloc/user_bloc.dart';
import 'package:toastification/toastification.dart';

class JobRecruitments extends StatefulWidget {
  final String user_id;

  const JobRecruitments({super.key, required this.user_id});

  @override
  State<JobRecruitments> createState() => _JobRecruitmentsState();
}

class _JobRecruitmentsState extends State<JobRecruitments> {
  final fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    log("JR Build");
    log(widget.user_id);
    context.read<UserBloc>().add(UserGetUserJobRecruitments(widget.user_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const LoadingWidget(caption: "Loading...");
        }
        if (state is UserGetUserJobRecruitmentsSuccess) {
          return StreamBuilder(
            stream: state.jobRecruitments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(caption: "");
              }
              final feedSnapShot = snapshot.data!.docs;
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(
                  errorMessage: "No Job Recruitments found.",
                );
              }
              return ListView.builder(
                itemCount: feedSnapShot.length,
                itemBuilder: (context, index) {
                  final feedData = feedSnapShot[index].data();
                  final feedId = feedSnapShot[index].id;

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      highlightColor: AppPallete.lightBlue,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    changeToTimeAgo(feedData['created_at']),
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
        }
        return const SizedBox();
      },
    );
  }
}
