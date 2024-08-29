import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/feed/presentation/widgets/user_card.dart';
import 'package:freezed_example/features/profile/presentation/bloc/user_bloc.dart';
import 'package:toastification/toastification.dart';

class JobRecruiter extends StatefulWidget {
  final String jobRecruiterId;
  const JobRecruiter({super.key, required this.jobRecruiterId});

  @override
  State<JobRecruiter> createState() => _JobRecruiterState();
}

class _JobRecruiterState extends State<JobRecruiter> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserGetUserInfo(widget.jobRecruiterId));
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
          return const LoadingWidget(caption: "");
        }

        if (state is UserSuccess) {
          return StreamBuilder(
            stream: state.userInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(caption: "");
              }
              final userSnapShot = snapshot.data!.data();

              return UserCard(userData: userSnapShot!);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
