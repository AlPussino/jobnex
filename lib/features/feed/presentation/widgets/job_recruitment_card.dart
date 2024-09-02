import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/features/feed/presentation/pages/job_recruitment_detail_page.dart';

class JobRecruitmentCard extends StatelessWidget {
  final Map<String, dynamic> recruitmentData;
  final String recruitmentId;
  final int index;
  const JobRecruitmentCard(
      {super.key,
      required this.recruitmentData,
      required this.recruitmentId,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                  Navigator.pushNamed(
                    context,
                    JobRecruitmentDetailPage.routeName,
                    arguments: {
                      "jobRecruitmentData": recruitmentData,
                      "jobRecruitmentId": recruitmentId,
                    },
                  );
                },
                child: Card(
                  child: Container(
                    width: size.width,
                    height: size.width / 2,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              recruitmentData['company_name'],
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                            ),
                            Text(
                              changeToTimeAgo(
                                recruitmentData['created_at'],
                              ),
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          recruitmentData['job_position'],
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleLarge!
                              .copyWith(color: AppPallete.lightBlue),
                        ),
                        Text(
                          recruitmentData['role_responsibility'],
                          style: Theme.of(context).primaryTextTheme.titleSmall,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                                label: Text(
                              recruitmentData['sallary_range'],
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            )),
                            Text(
                              recruitmentData['job_location'],
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ).animate(delay: const Duration(seconds: 2)).shimmer(),
    );
//
  }
}
