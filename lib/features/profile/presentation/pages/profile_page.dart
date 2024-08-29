import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/auth_gate.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/features/profile/presentation/pages/add_work_experiences_page.dart';
import 'package:freezed_example/features/profile/presentation/widgets/job_recruitments.dart';
import 'package:freezed_example/features/profile/presentation/widgets/profile_card.dart';
import 'package:freezed_example/features/profile/presentation/widgets/work_experiences.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-page';
  final String user_id;

  const ProfilePage({super.key, required this.user_id});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(
      () => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          actions: widget.user_id == fireAuth.currentUser!.uid
              ? [
                  IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then(
                        (value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AuthGate.routeName, (route) => false);
                        },
                      );
                    },
                    icon: const Icon(
                      Iconsax.logout_bold,
                      color: AppPallete.white,
                    ),
                  ),
                ]
              : null,
        ),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              tabs: const [
                Tab(text: "User Profile"),
                Tab(text: "Work Experience"),
                Tab(text: "Job Recruitments"),
                // Tab(text: "Save Certificate"),
                // Tab(text: "Comment Tree"),
                // Tab(text: "Quzi"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                dragStartBehavior: DragStartBehavior.down,
                children: [
                  ProfileCard(user_id: widget.user_id),
                  WorkExperiences(user_id: widget.user_id),
                  JobRecruitments(user_id: widget.user_id),
                  // const SaveCertificate(),
                  // const TestCommentTree(),
                  // const AnswerQuizPage(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: tabController.index == 1 &&  widget.user_id==fireAuth.currentUser!.uid
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddWorkExperiencePage.routeName);
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
