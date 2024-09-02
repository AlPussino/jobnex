import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:freezed_example/features/feed/presentation/pages/add_recruitment_page.dart';
import 'package:freezed_example/features/feed/presentation/widgets/job_recruitment_card.dart';
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
          return const LoadingWidget();
        }
        if (state is FeedFailure) {
          return ErrorWidgets(errorMessage: state.message);
        }
        if (state is FeedGetAllJobRecruitmentsSuccessState) {
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
              return AnimationLimiter(
                child: ListView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  addSemanticIndexes: false,
                  shrinkWrap: false,
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
                ),
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
          return const LoadingWidget();
        }
        if (state is FeedGetAllJobRecruitmentsSuccessState) {
          return StreamBuilder(
            stream: state.jobRecruitments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
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

                  return JobRecruitmentCard(
                    recruitmentData: feedData,
                    recruitmentId: feedId,
                    index: index,
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
