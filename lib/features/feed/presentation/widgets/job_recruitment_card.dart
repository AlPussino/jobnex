import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/features/feed/presentation/pages/job_recruitment_detail_page.dart';

class JobRecruitmentCard extends StatelessWidget {
  final Map<String, dynamic> recruitmentData;
  final String recruitmentId;
  const JobRecruitmentCard(
      {super.key, required this.recruitmentData, required this.recruitmentId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    Text(recruitmentData['company_name']),
                    Text(
                      changeToTimeAgo(recruitmentData['created_at']),
                    ),
                  ],
                ),
                Text(recruitmentData['job_position']),
                Text(recruitmentData['role_responsibility'],
                    softWrap: false, overflow: TextOverflow.fade),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(label: Text(recruitmentData['sallary_range'])),
                    Text(recruitmentData['job_location']),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
