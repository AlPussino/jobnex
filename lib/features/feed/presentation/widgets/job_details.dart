import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/features/feed/presentation/widgets/job_recruiter.dart';

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
            style: Theme.of(context).primaryTextTheme.headlineMedium,
          ),
          SizedBox(height: size.height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                jobRecruitmentData['company_name'],
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              Text(jobRecruitmentData['job_location']),
            ],
          ),
          SizedBox(height: size.height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                jobRecruitmentData['sallary_range'],
              ),
              Chip(
                label: Text(
                  jobRecruitmentData['job_type'],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height / 40),
          ListTile(
            title: const Text('Experience'),
            subtitle: Text(
              jobRecruitmentData['years_of_experience'],
            ),
          ),
          const ListTile(title: Text('Skills')),
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
