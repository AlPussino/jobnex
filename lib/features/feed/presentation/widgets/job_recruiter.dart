import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/profile/presentation/bloc/user_bloc.dart';
import 'package:freezed_example/features/profile/presentation/pages/profile_page.dart';
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
          return const LoadingWidget(caption: "");
        }

        if (state is UserSuccess) {
          return Card(
            child: StreamBuilder(
              stream: state.userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(caption: "");
                }
                final userSnapShot = snapshot.data!.data();
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName,
                        arguments: snapshot.data!.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              userSnapShot!['profile_url']),
                        ),
                        SizedBox(width: size.width / 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userSnapShot['name'],
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                            Text(
                              userSnapShot['email'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
