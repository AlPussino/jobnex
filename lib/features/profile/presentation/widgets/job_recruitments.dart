import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/feed/presentation/widgets/job_recruitment_card.dart';
import 'package:JobNex/features/profile/presentation/bloc/user_bloc.dart';
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
    context.read<UserBloc>().add(UserGetUserJobRecruitments(widget.user_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const LoadingWidget();
        }
        if (state is UserGetUserJobRecruitmentsSuccess) {
          return StreamBuilder(
            stream: state.jobRecruitments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }
              final recruitmentSnapShot = snapshot.data!.docs;
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const ErrorWidgets(
                  errorMessage: "No Job Recruitments found.",
                );
              }
              return ListView.builder(
                itemCount: recruitmentSnapShot.length,
                itemBuilder: (context, index) {
                  final recruitmentData = recruitmentSnapShot[index].data();
                  final recruitmentId = recruitmentSnapShot[index].id;

                  return JobRecruitmentCard(
                    recruitmentData: recruitmentData,
                    recruitmentId: recruitmentId,
                    index: index,
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
