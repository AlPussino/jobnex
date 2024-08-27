import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/duration_different.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/profile/presentation/bloc/work_experience_bloc.dart';
import 'package:freezed_example/features/profile/presentation/pages/work_experience.detail_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class WorkExperiences extends StatefulWidget {
  final String user_id;
  const WorkExperiences({super.key, required this.user_id});

  @override
  State<WorkExperiences> createState() => _WorkExperiencesState();
}

class _WorkExperiencesState extends State<WorkExperiences> {
  final fireAuth = FirebaseAuth.instance;
  @override
  void initState() {
    log("EXP Build");
    context
        .read<WorkExperienceBloc>()
        .add(WorkExperienceGetWorkExperience(widget.user_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkExperienceBloc, WorkExperienceState>(
      listenWhen: (previous, current) => current is WorkExperienceFailure,
      buildWhen: (previous, current) =>
          current is WorkExperienceGetWorkExperienceSuccess,
      listener: (context, state) {
        if (state is WorkExperienceFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is WorkExperienceLoading) {
          return const LoadingWidget(caption: "");
        }
        if (state is WorkExperienceFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }
        if (state is WorkExperienceGetWorkExperienceSuccess) {
          return StreamBuilder(
            stream: state.workExperiences,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(caption: "");
              }
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(
                    errorMessage: "This motherfucker has no experiences.");
              }
              final snapShotData = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapShotData.length,
                  itemBuilder: (context, index) {
                    final workExperience = snapShotData[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, WorkExperienceDetailPage.routeName,
                            arguments: {
                              "workExperience": workExperience.id,
                              "user_id": widget.user_id,
                            });
                      },
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          isThreeLine: true,
                          leading: const Icon(Iconsax.briefcase_bold),
                          title: Text(workExperience['job_position'],
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workExperience['company_name'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall,
                              ),
                              Text(
                                workExperience['job_location'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall,
                              ),
                            ],
                          ),
                          trailing: Text(workExperience['still_working']
                              ? "Still working"
                              : calculateDurationDifference(
                                      DateTime.parse(
                                          workExperience['start_date']),
                                      DateTime.parse(
                                          workExperience['stop_date']))
                                  .toString()),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
        return const ErrorWidgets(errorMessage: "No Active State");
      },
    );
  }
}
