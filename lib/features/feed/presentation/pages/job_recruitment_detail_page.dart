import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/features/feed/presentation/pages/job_apply_button.dart';
import 'package:freezed_example/features/feed/presentation/widgets/candidates_list.dart';
import 'package:freezed_example/features/feed/presentation/widgets/role_responsibilities.dart';
import 'package:freezed_example/features/feed/presentation/widgets/job_details.dart';
import 'package:freezed_example/features/feed/presentation/widgets/oppotunities.dart';

class JobRecruitmentDetailPage extends StatelessWidget {
  static const routeName = '/job-recruitment-detail-page';
  final Map<String, dynamic> JobRecruitmentData;
  final String jobRecruitmentId;

  const JobRecruitmentDetailPage({
    super.key,
    required this.JobRecruitmentData,
    required this.jobRecruitmentId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fireAuth = FirebaseAuth.instance;
    List<String> skillList = JobRecruitmentData['skills'].split(',');
    List<dynamic> candidateList = JobRecruitmentData['candidates'];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  // child: CachedNetworkImage(
                  //   imageUrl:
                  //       "https://plus.unsplash.com/premium_photo-1661962349501-10bf5556f79b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  //   fit: BoxFit.cover,
                  // ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(fontSize: 70.0),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ScaleAnimatedText('We are hiring'),
                          ScaleAnimatedText('a'),
                          ScaleAnimatedText(JobRecruitmentData['job_position']),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppPallete.white,
                    child: BackButton(
                      color: AppPallete.elevatedButtonBackgroundColor,
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  snap: true,
                  maxChildSize: 1,
                  minChildSize: 0.2,
                  initialChildSize: 0.8,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: DefaultTabController(
                        length: JobRecruitmentData['recruiter_id'] ==
                                fireAuth.currentUser!.uid
                            ? 4
                            : 3,
                        child: Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: AppPallete.cardBackgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                // const BackButton(),
                                SafeArea(
                                  child: TabBar(
                                    automaticIndicatorColorAdjustment: true,
                                    isScrollable: true,
                                    physics: const BouncingScrollPhysics(),
                                    tabs: JobRecruitmentData['recruiter_id'] ==
                                            fireAuth.currentUser!.uid
                                        ? const [
                                            Tab(text: 'Details'),
                                            Tab(text: 'Oppotunities'),
                                            Tab(text: 'Responsibles'),
                                            Tab(text: 'Candidates')
                                          ]
                                        : const [
                                            Tab(text: 'Details'),
                                            Tab(text: 'Oppotunities'),
                                            Tab(text: 'Responsibles'),
                                          ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children:
                                        JobRecruitmentData['recruiter_id'] ==
                                                fireAuth.currentUser!.uid
                                            ? [
                                                JobDetail(
                                                  size: size,
                                                  jobRecruitmentData:
                                                      JobRecruitmentData,
                                                  skillList: skillList,
                                                  jobRecruitmentId:
                                                      jobRecruitmentId,
                                                ),
                                                Oppotunities(
                                                  size: size,
                                                  JobRecruitmentData:
                                                      JobRecruitmentData,
                                                ),
                                                RoleResponsiblities(
                                                  size: size,
                                                  JobRecruitmentData:
                                                      JobRecruitmentData,
                                                ),
                                                CandidatesList(
                                                  JobRecruitmentData:
                                                      JobRecruitmentData,
                                                ),
                                              ]
                                            : [
                                                JobDetail(
                                                  size: size,
                                                  jobRecruitmentData:
                                                      JobRecruitmentData,
                                                  skillList: skillList,
                                                  jobRecruitmentId:
                                                      jobRecruitmentId,
                                                ),
                                                Oppotunities(
                                                  size: size,
                                                  JobRecruitmentData:
                                                      JobRecruitmentData,
                                                ),
                                                RoleResponsiblities(
                                                  size: size,
                                                  JobRecruitmentData:
                                                      JobRecruitmentData,
                                                ),
                                              ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          JobRecruitmentData['recruiter_id'] == fireAuth.currentUser!.uid
              ? const SizedBox()
              : JobApplyButton(
                  candiateList: candidateList,
                  JobRecruitmentData: JobRecruitmentData,
                  jobRecruitmentId: jobRecruitmentId,
                ),
        ],
      ),
    );
  }
}
