import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/feed/presentation/widgets/job_recruiter.dart';

class JobDetail extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> jobRecruitmentData;
  final String jobRecruitmentId;
  final List<String> skillList;
  const JobDetail({
    super.key,
    required this.size,
    required this.jobRecruitmentData,
    required this.jobRecruitmentId,
    required this.skillList,
  });

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            jobRecruitmentData['job_position'],
            style: Theme.of(context)
                .primaryTextTheme
                .titleLarge!
                .copyWith(color: AppPallete.lightBlue),
          ),
          SizedBox(height: size.height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                jobRecruitmentData['company_name'],
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              Text(
                jobRecruitmentData['job_location'],
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: size.height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                jobRecruitmentData['sallary_range'],
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              Chip(
                label: Text(
                  jobRecruitmentData['job_type'],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height / 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Experience',
                style: Theme.of(context).primaryTextTheme.bodySmall,
              ),
              Text(
                jobRecruitmentData['years_of_experience'],
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: size.height / 40),
          Text(
            'Skills',
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: skillList.map((item) {
              return Chip(
                label: Text(item.trim()),
              );
            }).toList(),
          ),
          SizedBox(height: size.height / 40),
          jobRecruitmentData['recruiter_id'] != fireAuth.currentUser!.uid
              ? JobRecruiter(jobRecruiterId: jobRecruitmentData['recruiter_id'])
              : const SizedBox(),
        ],
      ),
    );
  }
}
