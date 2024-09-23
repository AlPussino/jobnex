import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/core/util/duration_different.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/profile/presentation/bloc/work_experience_bloc.dart';
import 'package:JobNex/features/profile/presentation/pages/work_experience.detail_page.dart';
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
          return const LoadingWidget();
        }
        if (state is WorkExperienceFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }
        if (state is WorkExperienceGetWorkExperienceSuccess) {
          return StreamBuilder(
            stream: state.workExperiences,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(
                    errorMessage: "This motherfucker has no experiences.");
              }
              final snapShotData = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapShotData.length,
                    itemBuilder: (context, index) {
                      final workExperience = snapShotData[index];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          horizontalOffset: 30,
                          verticalOffset: 300,
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FlipAnimation(
                            duration: const Duration(milliseconds: 3000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            flipAxis: FlipAxis.y,
                            child: FadeInUp(
                              from: index * 10,
                              duration: const Duration(milliseconds: 100),
                              delay: const Duration(milliseconds: 100),
                              animate: true,
                              curve: Curves.bounceIn,
                              child: InkWell(
                                highlightColor: AppPallete.lightBlue,
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      WorkExperienceDetailPage.routeName,
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
                                    title: Text(
                                      workExperience['job_position'],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          workExperience['company_name'],
                                        ),
                                        Text(
                                          workExperience['job_location'],
                                        ),
                                      ],
                                    ),
                                    trailing: Text(
                                        workExperience['still_working']
                                            ? "Still working"
                                            : calculateDurationDifference(
                                                    DateTime.parse(
                                                        workExperience[
                                                            'start_date']),
                                                    DateTime.parse(
                                                        workExperience[
                                                            'stop_date']))
                                                .toString()),
                                  ),
                                ),
                              ),
                            ),
                          )
                              .animate(delay: const Duration(seconds: 2))
                              .shimmer(),
                        ),
                      );
                    },
                  ),
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
