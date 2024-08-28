import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:freezed_example/features/feed/presentation/pages/add_recruitment_page.dart';
import 'package:freezed_example/features/feed/presentation/pages/job_recruitment_detail_page.dart';
import 'package:freezed_example/features/profile/presentation/pages/profile_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class FeedPage extends StatelessWidget {
  static const routeName = '/feed-page';
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.routeName,
                    arguments: fireAuth.currentUser!.uid);
              },
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    FirebaseAuth.instance.currentUser!.photoURL!),
              ),
            ),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          log(orientation.toString());
          return orientation == Orientation.portrait
              ? const FeedPagePortrait()
              : const FeedPageLandscape();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRecruitmentPage.routeName);
        },
        child: const Icon(Iconsax.add_outline),
      ),
    );
  }
}

class FeedPagePortrait extends StatelessWidget {
  const FeedPagePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FeedBloc>().add(FeedGetAllJobRecruitments());

    final size = MediaQuery.of(context).size;

    return BlocConsumer<FeedBloc, FeedState>(
      listenWhen: (previous, current) => current is FeedFailure,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {
        if (state is FeedFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is FeedLoading) {
          return const LoadingWidget(caption: "Adding...");
        }
        if (state is FeedFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }
        if (state is FeedGetAllJobRecruitmentsSuccessState) {
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
                                  Text(feedData['company_name']),
                                  Text(
                                    changeToTimeAgo(feedData['created_at']),
                                  ),
                                ],
                              ),
                              Text(feedData['job_position']),
                              Text(feedData['role_responsibility'],
                                  softWrap: false, overflow: TextOverflow.fade),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Chip(label: Text(feedData['sallary_range'])),
                                  Text(feedData['job_location']),
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
        return const SizedBox(
          child: ErrorWidgets(errorMessage: "No active state."),
        );
      },
    );
  }
}

class FeedPageLandscape extends StatelessWidget {
  const FeedPageLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FeedBloc>().add(FeedGetAllJobRecruitments());

    return BlocConsumer<FeedBloc, FeedState>(
      listenWhen: (previous, current) => current is FeedActionState,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {
        if (state is FeedFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        if (state is FeedLoading) {
          return const LoadingWidget(caption: "Adding...");
        }
        if (state is FeedGetAllJobRecruitmentsSuccessState) {
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

              return GridView.builder(
                itemCount: feedSnapShot.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  final feedData = feedSnapShot[index].data();
                  final feedId = feedSnapShot[index].id;
                  return InkWell(
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
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  feedData['company_name'],
                                ),
                                Text(
                                  changeToTimeAgo(feedData['created_at']),
                                ),
                              ],
                            ),
                            Text(
                              feedData['job_position'],
                            ),
                            Text(
                              feedData['role_responsibility'],
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text(
                                    feedData['sallary_range'],
                                  ),
                                ),
                                Text(
                                  feedData['job_location'],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return const SizedBox(
          child: ErrorWidgets(errorMessage: "No active state."),
        );
      },
    );
  }
}
