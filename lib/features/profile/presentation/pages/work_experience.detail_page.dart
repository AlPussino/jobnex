import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/constant/constant.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_date_format.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/profile/presentation/bloc/work_experience_bloc.dart';
import 'package:freezed_example/features/profile/presentation/pages/change_work_experiences_dates_page.dart';
import 'package:freezed_example/features/profile/presentation/widgets/change_work_experience_text_fields.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class WorkExperienceDetailPage extends StatefulWidget {
  static const routeName = '/work-experience-detail-page';
  final String workExperience_id;
  final String user_id;
  const WorkExperienceDetailPage(
      {super.key, required this.workExperience_id, required this.user_id});

  @override
  State<WorkExperienceDetailPage> createState() =>
      _WorkExperienceDetailPageState();
}

class _WorkExperienceDetailPageState extends State<WorkExperienceDetailPage> {
  @override
  void initState() {
    context.read<WorkExperienceBloc>().add(WorkExperienceGetWorkExperienceById(
        widget.user_id, widget.workExperience_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final companyNameController = TextEditingController();
    final jobPositionController = TextEditingController();
    final jobLocationController = TextEditingController();
    final jobTypeController = TextEditingController();
    final fireAuth = FirebaseAuth.instance;

    void changeCompanyName() {
      context.read<WorkExperienceBloc>().add(WorkExperienceChangeCompanyName(
          widget.workExperience_id, companyNameController.text));
      companyNameController.clear();
      FocusManager.instance.primaryFocus!.unfocus();
    }

    void changeJobPosition() {
      context.read<WorkExperienceBloc>().add(WorkExperienceChangeJobPosition(
          widget.workExperience_id, jobPositionController.text));
      jobPositionController.clear();
      FocusManager.instance.primaryFocus!.unfocus();
    }

    void changeJobLocation() {
      context.read<WorkExperienceBloc>().add(WorkExperienceChangeJobLocation(
          widget.workExperience_id, jobLocationController.text));
      jobLocationController.clear();
      FocusManager.instance.primaryFocus!.unfocus();
    }

    void changeJobType() {
      context.read<WorkExperienceBloc>().add(WorkExperienceChangeJobType(
          widget.workExperience_id, jobTypeController.text));
      jobTypeController.clear();
      FocusManager.instance.primaryFocus!.unfocus();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Experience Detail"),
      ),
      body: BlocConsumer<WorkExperienceBloc, WorkExperienceState>(
        listenWhen: (previous, current) => current is WorkExperienceFailure,
        buildWhen: (previous, current) =>
            current is WorkExperienceGetWorkExperienceByIdSuccess,
        listener: (context, state) {
          if (state is WorkExperienceFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is WorkExperienceChangeCompanyNameSuccess) {
            SnackBars.showToastification(
                context,
                "Company Name changed successfully.",
                ToastificationType.success);
            context.read<WorkExperienceBloc>().add(
                WorkExperienceGetWorkExperience(fireAuth.currentUser!.uid));
          }
          if (state is WorkExperienceChangeJobPositionSuccess) {
            SnackBars.showToastification(
                context,
                "Job position changed successfully.",
                ToastificationType.success);
            context.read<WorkExperienceBloc>().add(
                WorkExperienceGetWorkExperience(fireAuth.currentUser!.uid));
          }
          if (state is WorkExperienceChangeJobLocationSuccess) {
            SnackBars.showToastification(
                context,
                "Job Location changed successfully.",
                ToastificationType.success);
            context.read<WorkExperienceBloc>().add(
                WorkExperienceGetWorkExperience(fireAuth.currentUser!.uid));
          }
          if (state is WorkExperienceChangeJobTypeSuccess) {
            SnackBars.showToastification(context,
                "Job Type changed successfully.", ToastificationType.success);
            context.read<WorkExperienceBloc>().add(
                WorkExperienceGetWorkExperience(fireAuth.currentUser!.uid));
          }
        },
        builder: (context, state) {
          if (state is WorkExperienceLoading) {
            return const LoadingWidget(caption: "");
          }
          if (state is WorkExperienceGetWorkExperienceByIdSuccess) {
            return StreamBuilder(
                stream: state.workExperience,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget(caption: "");
                  }
                  final snapShotData = snapshot.data!.data()!;

                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          height: size.width,
                          width: size.width,
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: Constant
                                              .jobRecruitmentDetailBackground,
                                          fit: BoxFit.cover,
                                          width: size.width,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapShotData['job_position'],
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyMedium,
                                            ),
                                            Text(snapShotData['company_name']),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const CircleAvatar(
                                  radius: 65,
                                  backgroundColor:
                                      AppPallete.scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor:
                                        AppPallete.scaffoldBackgroundColor,
                                    child: Icon(
                                      Iconsax.briefcase_bold,
                                      size: 60,
                                      color: AppPallete
                                          .elevatedButtonBackgroundColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ),
                      const ListTile(
                        title: Text("Details"),
                      ),
                      SizedBox(
                        width: size.width,
                        child: Card(
                          child: Column(
                            children: [
                              const ListTile(title: Text("Company")),
                              ChangeWorkExperienceTextFields(
                                controller: companyNameController,
                                title: snapShotData['company_name'],
                                onPressed: changeCompanyName,
                                readOnly:
                                    fireAuth.currentUser!.uid != widget.user_id,
                              ),
                              const ListTile(title: Text("Position")),
                              ChangeWorkExperienceTextFields(
                                controller: jobPositionController,
                                title: snapShotData['job_position'],
                                onPressed: changeJobPosition,
                                readOnly:
                                    fireAuth.currentUser!.uid != widget.user_id,
                              ),
                              const ListTile(title: Text("Location")),
                              ChangeWorkExperienceTextFields(
                                controller: jobLocationController,
                                title: snapShotData['job_location'],
                                onPressed: changeJobLocation,
                                readOnly:
                                    fireAuth.currentUser!.uid != widget.user_id,
                              ),
                              const ListTile(title: Text("Type")),
                              ChangeWorkExperienceTextFields(
                                controller: jobTypeController,
                                title: snapShotData['job_type'],
                                onPressed: changeJobType,
                                readOnly:
                                    fireAuth.currentUser!.uid != widget.user_id,
                              ),
                              ListTile(
                                title: const Text("Start Date & End Date"),
                                trailing: widget.user_id ==
                                        fireAuth.currentUser!.uid
                                    ? IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            ChangeWorkExperiencesDatesPage
                                                .routeName,
                                            arguments: {
                                              "workExperience": snapShotData,
                                              "workExperience_id":
                                                  widget.workExperience_id,
                                            },
                                          );
                                        },
                                        icon: const Icon(Iconsax.edit_2_bold))
                                    : const SizedBox(),
                              ),
                              ListTile(
                                leading: const Icon(Iconsax.calendar_2_bold),
                                title: const Text("Start Date"),
                                subtitle: Text(changeDateFormat(
                                    snapShotData['start_date'])),
                              ),
                              ListTile(
                                leading: const Icon(Iconsax.calendar_2_bold),
                                title: Text(
                                  snapShotData['still_working']
                                      ? "Still working"
                                      : "End Date",
                                ),
                                subtitle: Text(snapShotData['still_working']
                                    ? "Still working"
                                    : changeDateFormat(
                                        snapShotData['stop_date'])),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
